class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :vicinity, :vote_count

  def vote_count
    object.votes.count
  end
end
