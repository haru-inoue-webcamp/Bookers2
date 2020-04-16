class UsersController < ApplicationController
before_action :authenticate_user!
before_action :require_user, only: [:edit, :update]

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
      flash[:success] = 'User info was successfully updated'
      redirect_to user_path(@user.id)
    else
      flash[:error] = 'User info was not updated error'
      redirect_to user_path(@user.id)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def require_user
    user = User.find(params[:id])
    if user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
