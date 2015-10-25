class Event < ActiveRecord::Base
  attr_accessor :place_ids
  has_many :destinations
  has_many :votes, :through => :destinations
end
