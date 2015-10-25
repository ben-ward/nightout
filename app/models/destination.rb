class Destination < ActiveRecord::Base
  has_many :votes
  belongs_to :event
end
