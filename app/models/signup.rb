class Signup < ActiveRecord::Base
  belongs_to :have, class_name: "Barterable", foreign_key: "have_id", autosave: true
  belongs_to :need, class_name: "Barterable", foreign_key: "need_id", autosave: true

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
                   length: { maximum: 32 }

  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: email_regex }

  validates_uniqueness_of :email,
                          message: "It looks like you've already signed up with that email. Contact jen@ourgoods.org if this in error."
end
