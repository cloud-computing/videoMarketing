class AddConvertedFinishedAtToVideos < ActiveRecord::Migration
	def change
		add_column :videos, :converted_finished_at, :datetime, :default => Time.zone.now
	end
end
