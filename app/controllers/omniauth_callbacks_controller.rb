class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    if User.whitelisted? request.env["omniauth.auth"]["info"]["email"]
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        session[:user] = @user.id
        sign_in_and_redirect @user, :event => :authentication
      else
        session[:user] = @user.id
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to logged_in_path
      end
    else
      flash[:alert] = "You need to log in with your Gawker Media account"
      redirect_to root_path
    end
  end
end
