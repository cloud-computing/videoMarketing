class HomeController < ApplicationController
	def index
		@videos = Video.where(:state => Video::CONVERTED_STATE.to_s()).all
		@video = Video.new
	end
end