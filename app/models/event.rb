class Event < ActiveRecord::Base
  attr_accessor :place_ids
  has_many :destinations
end
