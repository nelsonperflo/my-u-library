class BorrowingsController < ApplicationController
  before_action :logged_in_user
  before_action :librarian, except: :index

  def index
    if current_user.student?
      @borrowings = current_user.borrowings.includes(:book).order(id: :desc).paginate(page: params[:page])
    else
      @borrowings = Borrowing.includes(:book, :user)
      if params.has_key?(:search) && params[:search].present?
        @borrowings = Borrowing.search(params[:search])
      end
      @borrowings = @borrowings.order(id: :desc).paginate(page: params[:page])
    end
  end

  def show
    @borrowing = Borrowing.find(params[:id])
    @user = @borrowing.user
    @book = @borrowing.book
  end

  def return
    @borrowing = Borrowing.find(params[:id])
    @book = @borrowing.book
    begin
      Book.transaction do
        @book.stock.increase!
        @borrowing.update!(return_date: Time.zone.now)
      end
      flash[:success] = "The book was returned successfully."
    rescue ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid => e
      flash[:danger] = e.message
    rescue Exception => e
      flash[:danger] = e
    ensure
      redirect_to @borrowing
    end
  end

end
