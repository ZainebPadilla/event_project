class EventsController < ApplicationController
  
  before_action :authorize_admin, only: [:edit, :update, :destroy], skip_on_missing: true

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user

    if @event.save
      redirect_to @event, notice: "Bravo ! l'event a bien été créé"
    else
      render :new, alert: "Une erreur est survenue lors de la création de l'événement. Veuillez réessayer."

    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event, notice: "L'événement a été mis à jour avec succès"
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "L'événement a été supprimé avec succès"
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_date, :duration, :price)
  end

  def authorize_admin
    @event = Event.find(params[:id])
    redirect_to root_path, alert: "Accès refusé" unless @event.admin == current_user
  end
end
