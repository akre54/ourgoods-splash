class Event < ActiveRecord::Base
  has_many :signups
end
