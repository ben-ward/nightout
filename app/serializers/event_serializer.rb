class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :owner, :time, :deadline, :created_at, :updated_at

  has_many :destinations
end
