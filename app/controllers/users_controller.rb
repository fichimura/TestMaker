class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
    def index
    
      #@users = User.all.order(created_at: :desc)
  
      @q = User.ransack(params[:q])
      #@users = @q.result(distinct: true)  
      @pagy, @users = pagy(@q.result(distinct: true))
      authorize @users
    end

    def edit
      authorize @user
    end
  
    def update
      authorize @user
      if @user.update(user_params)
        redirect_to users_path, notice: 'Atribuições do usuário atualizada.'
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
  
      respond_to do |format|
        format.html { redirect_to '/users', notice: "Usuário deletado." }
        format.json { head :no_content }
      end
    end
    
    def show
    end

    private
  
    def set_user
      @user = User.friendly.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit({role_ids: []})
    end
end