class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:show]


  def show
    @user = User.find(params[:id])
    @organized_events = @user.organized_events
  end

  private #sert à rendre certaines méthodes du contrôleur (ou de la classe) accessibles uniquement à l'intérieur de cette classe. Cela signifie que ces méthodes ne peuvent pas être appelées directement depuis l'extérieur, comme par exemple depuis une vue ou une autre classe.

  def correct_user
    @user = User.find_by(id: params[:id])
    if @user.nil? || @user != current_user
      redirect_to(root_path, alert: "Accès refusé ") unless @user == current_user
    end
  end


end
