class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
  end

  def new
    @client = GooglePlaces::Client.new(ENV['API_KEY'])
    @places = @client.spots(20.7508119,-156.4401073, :types => ['restaurant','food','cafe','bars'])
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
        address1: nil,
        address2: nil,
        city: nil,
        state: nil,
        country: nil,
        postal: nil
      )
    end
    redirect_to event_path(@event), notice: 'Event created'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :time, :deadline, :place_ids)
  end

end
