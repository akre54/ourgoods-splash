class Signup < ActiveRecord::Base
  belongs_to :event

  belongs_to :have, class_name: "Barterable", foreign_key: "have_id"
  belongs_to :need, class_name: "Barterable", foreign_key: "need_id"

  accepts_nested_attributes_for :have, :need

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
                   length: { maximum: 32 }

  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: email_regex }

  validates_uniqueness_of :email,
                          message: "It looks like you've already signed up with that email. Contact jen@ourgoods.org if this in error."

  def first_name
    name.split(' ')[0]
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        attrs = product.attributes.values_at(*column_names)
        attrs[3] = Barterable.find(attrs[3]).description
        attrs[4] = Barterable.find(attrs[4]).description
        csv << attrs
      end
    end
  end
end
