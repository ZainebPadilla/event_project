class EventsController < ApplicationController
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
      render new_event_path

    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_date, :duration, :price)
  end
end
