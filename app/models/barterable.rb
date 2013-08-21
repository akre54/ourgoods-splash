class Barterable < ActiveRecord::Base

  validates :description, presence: true,
                          uniqueness: true,
                          length: { maximum: 128 }
end
