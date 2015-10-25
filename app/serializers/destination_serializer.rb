class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :vicinity, :vote_count

  def vote_count
    object.votes.count
  end
end
