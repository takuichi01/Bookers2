class BooksController < ApplicationController

  def index
    @books = Book.all
    @newbook = Book.new
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@newbook.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book)
    else
      render :edit
    end
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
