class Barterable < ActiveRecord::Base

  validates :description, presence: true,
               length: { within: 1..128 }
end
