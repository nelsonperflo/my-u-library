class UsersController < ApplicationController

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
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    # Helper methods

    def order_column
      User.column_names.include?(params[:order]) ? params[:order] : "id"
    end
    
    def order_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
  
end
