require 'twilio-ruby'
class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html
      format.json {
        render json: @event, serializer: EventSerializer
      }
    end
  end

  def new
    @client = GooglePlaces::Client.new(ENV['API_KEY'])
    @places = @client.spots(20.7508119,-156.4401073, :types => ['restaurant','cafe','bars'])
    @event = Event.new()
  end

  def create
    @event = Event.new(event_params)
    @client = GooglePlaces::Client.new(ENV['API_KEY'])
    @event.save
    @event.place_ids.split(',').each do |place_id|
      place = @client.spot(place_id)
      @event.destinations.create(
        name: place.name,
        latitude: place.lat,
        longitude: place.lng,
        vicinity: place.vicinity,
        address1: nil,
        address2: nil,
        city: nil,
        state: nil,
        country: nil,
        postal: nil
      )
    end
    @twilio_client = Twilio::REST::Client.new
    @twilio_client.messages.create(
      from: '+18084950075',
      to: '+18082805484',
      body: "Hi. Ben sent you a Nightout request. Click here to Vote #{event_url(@event)}"
    )
    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: 'Event created' }
      format.json {
        render json: @event, serializer: EventSerializer
      }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :time, :deadline, :place_ids)
  end

end
