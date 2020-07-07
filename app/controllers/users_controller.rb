class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # debugger こいつを差し込むことでレスポンスを送る前にターミナル上で変数の中身とかを見ることができる
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # redirect_to @user
      flash[:success] = "Welcome to the Sample App!!"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end