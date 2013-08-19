class Signup < ActiveRecord::Base
  belongs_to :have, class_name: "Barterable", foreign_key: "have_id"
  belongs_to :need, class_name: "Barterable", foreign_key: "need_id"

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
                   length: { within: 1..32 }

  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 255 },
                    format: { with: email_regex }
end
