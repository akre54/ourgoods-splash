class AddNoteToEvents < ActiveRecord::Migration
  def change
    add_column :events, :note, :string, null: true, default: ''

    Event.all do |evt|
      evt.update_attribute :note, ''
    end

    change_column_null :events, :note, false
  end
end
