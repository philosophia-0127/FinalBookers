class BooksController < ApplicationController
  # def new
  #   @book = Book.new
  # end

  def index
    @books = Book.all
    @newbook = Book.new
    @user = current_user
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@newbook.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = current_user
    @booker = @book.user

    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
      unless @book.user == current_user
        redirect_to books_path
      end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
