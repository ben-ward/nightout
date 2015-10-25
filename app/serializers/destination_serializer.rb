class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :vicinity, :vote_count, :time_estimate

  def time_estimate
    object.time_estimate
  end

end
