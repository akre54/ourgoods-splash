class Barterable < ActiveRecord::Base

  validates :description, presence: true,
                          length: { maximum: 128 }
end
