module UsersHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    if current_user
      true
    else
      false
    end
  end
end
