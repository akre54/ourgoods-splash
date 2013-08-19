class Signup < ActiveRecord::Base
  belongs_to :have, class_name: "Barterable", foreign_key: "have_id"
  belongs_to :need, class_name: "Barterable", foreign_key: "need_id"
end
