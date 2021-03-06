class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @review_count = Book.where(id: Book.new).where(user_id: current_user.id).count
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @review_count = Book.where(id: @books).where(user_id: current_user.id).count
  end

  def edit
    @user = User.find(params[:id])
    if
      @user == current_user
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user

  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user

  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
