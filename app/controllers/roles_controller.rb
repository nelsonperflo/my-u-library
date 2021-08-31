class RolesController < ApplicationController
  before_action :logged_in_user
  before_action :librarian

  def index
    @roles = Role.order(id: :asc).paginate(page: params[:page])
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      flash[:success] = "Role created successfully."
      redirect_to roles_path
    else
      render 'new'
    end
  end

  def show
    @role = Role.find(params[:id])
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update(role_params)
      flash[:success] = "Role updated successfully."
      redirect_to @role
    else
      render 'edit'
    end
  end

  private

    def role_params
      params.require(:role).permit(:name)
    end

    def librarian
      unless current_user.librarian?
        flash[:danger] = "You don't have permission to perform this action."
        redirect_to root_path
      end
    end

end
