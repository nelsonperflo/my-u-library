class BooksController < ApplicationController
  before_action :logged_in_user
  before_action :librarian, only: [:new, :create, :edit, :update]
  before_action :student, only: [:checkout]

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
      @book.create_stock!(quantity: @book.copies)
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

  def checkout
    @book = Book.find(params[:id])
    if @book.stock.available?
      @borrowing = @book.borrowings.build(user: current_user, borrowed_date: Time.zone.now)
      begin
        Book.transaction do
          @book.stock.decrease!
          @borrowing.save!
        end
      rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid => e
        flash[:danger] = e.message
      rescue Exception => e
        flash[:danger] = e
      ensure
        redirect_to @book and return
      end
      flash[:success] = "The book was check out successfully."
      redirect_to @book
    else
      flash[:danger] = "The book was not checked out. Available copies: #{@book.stock.quantity}"
      redirect_to @book
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :author, :published_year, :genre, :copies)
    end
end
