require 'twilio-ruby'
class VotesController < ApplicationController

  def create
    @destination = Destination.find(params[:destination_id])
    @vote = Vote.create(destination_id: @destination.id)
    @destination.update_attributes(vote_count: @destination.votes.count)
    @event = @destination.event
    if @event.votes.count >= 4
      @twilio_client = Twilio::REST::Client.new
      @twilio_client.messages.create(
        from: '+18084950075',
        to: '+18082805484',
        body: "Nice! We have decided to go to #{@event.destinations.order('vote_count DESC').first.name} Call an Uber here. #{event_url(@event)}"
      )
      @twilio_client.messages.create(
        from: '+18084950075',
        to: '+18082800766',
        body: "Nice! We have decided to go to #{@event.destinations.order('vote_count DESC').first.name} Call an Uber here. #{event_url(@event)}"
      )
      @twilio_client.messages.create(
        from: '+18084950075',
        to: '+16126007305',
        body: "Nice! We have decided to go to #{@event.destinations.order('vote_count DESC').first.name} Call an Uber here. #{event_url(@event)}"
      )
    end
    respond_to do |format|
      format.html { redirect_to event_path(@destination.event), notice: 'Thanks for your vote' }
      format.json {
        render json: @destination.event, serializer: EventSerializer
      }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def vote_params
    params.require(:vote).permit(:user_id, :destination_id)
  end

end
