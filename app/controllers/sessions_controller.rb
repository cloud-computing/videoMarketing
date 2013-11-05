class SessionsController < ApplicationController

  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Sesión de usuario iniciada."
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Sesión de usuario terminada."
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registro exitoso"
    else
      flash[:notice] = "Formulario inválido"
    end
    session[:user_id] = @user.id
    redirect_to root_url, :notice => "Registro exitoso."
  end

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:user][:email],params[:user][:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Bienvenido(a) #{authorized_user.name}"
    else
      flash[:notice] = "Nombre de usuario o contraseña inválidos"
    end
    redirect_to root_url
  end

end