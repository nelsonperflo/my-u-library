class BooksController < ApplicationController
  before_action :logged_in_user
  before_action :librarian

  def index
    @books = Book.order(title: :asc)
    if params.has_key?(:search) && params[:search].present?
      @books = Book.search(params[:search])
    end
    @books = @books.paginate(page: params[:page])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = "Book created successfully."
      redirect_to @book
    else
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "Book updated successfully."
      redirect_to @book
    else
      render 'edit'
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :author, :published_year, :genre)
    end
end
