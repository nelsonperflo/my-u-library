class BorrowingsController < ApplicationController
  before_action :logged_in_user
  before_action :librarian, except: :index

  def index
    if current_user.student?
      @borrowings = current_user.borrowings.includes(:book).order(id: :desc).paginate(page: params[:page])
    else
      @borrowings = Borrowing.includes(:book, :user).order(id: :desc).paginate(page: params[:page])
    end
  end

  def new
    @borrowing = Borrowing.new
  end

  def create
    @borrowing = Borrowing.new(borrowing_params)
    if @borrowing.save
      flash[:success] = "Borrowing created successfully."
      redirect_to @borrowing
    else
      render 'new'
    end
  end

  def show
    @borrowing = Borrowing.find(params[:id])
  end

  def edit
    @borrowing = Borrowing.find(params[:id])
  end

  def update
    @borrowing = Borrowing.find(params[:id])
    if @borrowing.update(borrowing_params)
      flash[:success] = "Borrowing updated successfully."
      redirect_to @borrowing
    else
      render 'edit'
    end
  end

  private

    def borrowing_params
      params.require(:borrowing).permit(:user_id, :book_id, :borrowed_date, :return_date)
    end
end
