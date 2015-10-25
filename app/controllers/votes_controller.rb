class VotesController < ApplicationController

  def create
    @destination = Destination.find(params[:destination_id])
    @vote = Vote.create(destination_id: @destination.id)
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
