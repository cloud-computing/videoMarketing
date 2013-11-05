class VideosController < ApplicationController
  before_filter :authenticate

  def authenticate
    redirect_to :login unless current_user
  end
  
  def new
    @video = Video.new
  end

  def create
    uploader = VideoUploader.new
    if uploader.store!(params[:video][:video])
      @video = Video.new
      @video.message = params[:video][:message]
      @video.email = params[:video][:email]
      @video.video_url = uploader.url
      @video.state = Video::PROCESSING_STATE
      if @video.save
        flash[:success] = 'Hemos recibido el video, pronto lo revisaremos y publicaremos. Gracias por participar en el concurso.'
        redirect_to root_path
      else
        flash[:error] = 'Error cargando el video.'
        render 'new'
      end
    end
  end

  def index
    @videos = Video.where(:email => current_user.email).all
  end
end