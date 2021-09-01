class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :librarian, except: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User updated successfully."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_id)
    end   

    def correct_user
      @user = User.find(params[:id])      
      unless current_user == @user || current_user.librarian?
        flash[:danger] = "You don't have permission to perform this action."
        redirect_to root_path
      end
    end
  
end
