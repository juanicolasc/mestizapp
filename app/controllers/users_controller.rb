class UsersController < ApplicationController

  append_before_action do
    unless current_user && current_user.admin?
      flash[:alert] = 'No tiene permiso para esta acción'
      redirect_to root_path
    end
  end

  def index
    @users = User.all
  end

  def new
      @user = User.new
  end

  def create
      @user = User.new(user_params)
      if @user.save
        redirect_to users_path, :notice => "¡Usuario registrado exitosamente!"
      else
        render "new"
      end
  end


  # GET /products/1/edit
  def edit
      @user = User.find(params[:id])
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, :notice => "¡Usuario actualizado exitosamente!"
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :profile)
    end
end
