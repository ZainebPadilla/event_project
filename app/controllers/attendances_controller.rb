class AttendancesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_event

  def index
    @event = Event.find(params[:event_id])
    @attendees = @event.attendees
  end
  
  def new
  end

  def create
    
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

end
