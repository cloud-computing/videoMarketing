class Video
  include Dynamoid::Document

	#mount_uploader :video, VideoUploader
	#mount_uploader :video_converted, VideoConvertedUploader

  table :name => :videos, :read_capacity => 10, :write_capacity => 10

  field :video_url
  field :message
  field :converted_at, :datetime
  field :state
  field :video_converted_url
  field :converted_finished_at, :datetime
  field :email

	validates :message, :presence => true
	validates :state, :presence => true
	validates :video_url, :presence => true
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, :presence => true, :format => { :with => email_regex }

	#scope :converted, where('videos.converted_finished_at IS NOT NULL')
	#scope :ordered_desc_by_created_at, order('videos.created_at DESC')

	PROCESSING_STATE = 0
	CONVERTED_STATE = 1

	after_save :convert_video

	def convert_video
		self.delay.process_video
	end

	def process_video
		puts 'Convirtiendo video...'
		if self.converted_at.nil?
			self.converted_at = Time.zone.now

			video_url = Rails.root.join("public/uploads/video/video/#{DateTime.now}")
			Dir.mkdir(video_url)
			video_url = video_url.to_s() + "/" + self.video_url.split('/').last
			open(video_url, 'wb') do |file|
				file << open(self.video_url).read
			end
			puts 'Video url: '+video_url

			movie = FFMPEG::Movie.new(video_url)
			options = {video_codec: "libx264"}
			video_name = self.video_url.split('/').last
			video_converted_url = "#{Rails.root}/tmp/converted_#{UUIDTools::UUID.random_create.hexdigest}_"+video_name[0,video_name.size-4]+'.mp4'
			puts 'Converted url: '+video_converted_url
			movie.transcode(video_converted_url, options)

			uploaderConverted = VideoConvertedUploader.new
			if uploaderConverted.store!(File.open(video_converted_url))
				self.video_converted_url = uploaderConverted.url
				self.state = CONVERTED_STATE
				self.converted_finished_at = Time.zone.now
				if self.save
					File.delete(video_converted_url)
				end
			end
		end
	end
end