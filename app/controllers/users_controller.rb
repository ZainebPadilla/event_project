class UsersController < ApplicationController
  
  before_action :authenticate_user!
  befor_action :correct_user, only [:show]

  def show
    @user = User.find(params[:id])
    @events = @user.events.where(admin_id: @user.id) #pour que les events montrés soient ceux du user
  end

  def current_user
    @user = User.find(params[:id])
    redirect_to(root_path, alert: "Accès refusé ") unless @user == current_user
  end
end
