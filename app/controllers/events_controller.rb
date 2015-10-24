class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to event_path(@event), notice: 'Event created'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.permit(:name, :time, :deadline)
  end

end
