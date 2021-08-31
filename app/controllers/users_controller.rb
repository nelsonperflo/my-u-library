class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def index
    @users = User.includes(:role).order(id: :desc)
    if params.has_key?(:search) && params[:search].present?
      @users = User.search(params[:search])
    end
    @users = @users.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created successfully."
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_id)
    end
  
end
