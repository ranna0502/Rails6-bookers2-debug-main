class BooksController < ApplicationController
  helper_method :sort_column, :sort_direction

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @post_comment = PostComment.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @review_count = Book.where(id: Book.new).where(user_id: current_user.id).count
  end

  def index
    @user = current_user
    @books = Book.order("#{sort_column} #{sort_direction}")
    @book_new = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @review_count = Book.where(id: params[:id]).where(user_id: current_user.id).count
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @review_count = Book.where(id: params[:id]).where(user_id: current_user.id).count
    if @book.user != current_user
      redirect_to books_path, alert: 'Warring!!'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:star)
  end

  def sort_direction
   %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
   Book.column_names.include?(params[:sort]) ? params[:sort] : 'title'
  end


end
