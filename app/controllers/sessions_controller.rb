class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user # redirect_to user_url(user)
      else
        message = "Account not activated"
        messages += "Check your email for the activation link."
      end
    else
      flash.now[:danger] = 'Invalid emai/password combination'
      render 'new' # リダイレクトではない => リクエストを送らないのでflashが消えない
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
