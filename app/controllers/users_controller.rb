class UsersController < ApplicationController
  def create
    up = params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    user = User.new(up)
    if user.save
      flash[:success] = "Welcome to the Slowest app!"
      sign_in user
      redirect_to root_path
    else
      flash[:error] = "Something went wrong with your signup."
      redirect_to new_session_path
    end
  end

  def show
    @user = User.includes(:shows, :venues).find(params[:id])
    if signed_in?
      @following = current_user.outward_follows.where(
        :followed_id => @user.id).exists?
    end
  end

  def index
    @users = User.all
  end
end