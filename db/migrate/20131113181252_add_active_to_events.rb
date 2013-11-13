class AddActiveToEvents < ActiveRecord::Migration
  def change
    add_column :events, :active, :boolean, default: true, null: false
    Event.all.each { |e| e.update_attribute :active, false }
    Event.last.update_attribute :active, true
  end
end
