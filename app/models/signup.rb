class Signup < ActiveRecord::Base
  belongs_to :event

  belongs_to :item,      class_name: "Barterable", foreign_key: "item_id"
  belongs_to :skill,     class_name: "Barterable", foreign_key: "skill_id"

  accepts_nested_attributes_for :item, :skill

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
                   length: { maximum: 32 }

  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: email_regex }

  validates_uniqueness_of :email,
                          scope: :event_id,
                          message: "It looks like you've already signed up for this event with that email. Contact jen@ourgoods.org if this in error."

  validate :has_at_least_one_barterable

  def first_name
    name.split(' ')[0]
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |signup|
        attrs = signup.attributes.values_at(*column_names)
        attrs[3] = Barterable.find(attrs[3]).description
        attrs[4] = Barterable.find(attrs[4]).description
        attrs[7] = I18n.l Event.find(attrs[7]).event_begin_time, format: :event_date
        csv << attrs
      end
    end
  end

private

  def has_at_least_one_barterable
    if community.blank? && !item.present? && !skill.present?
      self.errors[:base] << "Please answer one question"
    end
  end
end
