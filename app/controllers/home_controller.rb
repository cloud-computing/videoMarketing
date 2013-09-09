class HomeController < ApplicationController
	def index
		@videos = Video.converted.ordered_desc_by_created_at.page(params[:page]).per(30)
		@video = Video.new
	end
end