class BooksController < ApplicationController
before_action :authenticate_user!
before_action :require_user, only: [:edit, :update, :destroy]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = 'Book was successfully created'
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      flash[:error] = 'Book was not created error'
      render 'index'
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if  book.update(book_params)
      flash[:success] = 'Book was successfully updated'
      redirect_to book_path(book.id)
    else
      flash[:error] = 'Book was not updated error'
      redirect_to book_path(book.id)
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path
      flash[:success] = 'Book was successfully destroyed'
    else
      flash[:error] = 'Book was not destroyed error'
      redirect_to book_path(book.id)
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def require_user
    book = Book.find(params[:id])
    user = book.user
    if user.id != current_user.id
      redirect_to books_path
    end
  end
end
