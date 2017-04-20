class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password is invalid'
      render :new
    end
  end

  def create_from_omniauth
    byebug
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = user_path(user)
      @notice = "You're signed in again with fb"
    else
      user = User.create_with_auth_and_hash(authentication,auth_hash)
      @next = user_path(user)
      @notice = "Signed in first time with facebook"
    end
    session[:user_id] = user.id
    redirect_to @next, :notice => @notice
  end

  def destroy
  session[:user_id] = nil
  redirect_to root_url, notice: 'Logged out'
  end




end
