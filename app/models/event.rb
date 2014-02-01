class Event < ActiveRecord::Base
  has_many :signups

  scope :active, lambda { where("event_begin_time >= ?", Time.now).order('event_begin_time asc') }
end
