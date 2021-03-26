class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = book.favorites.new(user_id: current_user.id)
    favorite.save
    # if request.path == books_path
    #   redirect_to book_path(book)
    # else
    #   redirect_to books_path
    # end

    # redirect_back(fallback_location: root_path)
    redirect_to request.referer
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referer
  end

end
