class ChangeDateToDatetime < ActiveRecord::Migration
  def change
    add_column :events, :event_begin_time, :datetime
    add_column :events, :event_finish_time, :datetime

    Event.all.each do |evt|
      time = evt.time.split('-')
      d = Date.parse evt.date
      b = Time.parse "#{time.first}pm"
      f = Time.parse time.last

      # ugly hack...
      year = d.month != 1 ? 2103 : 2014

      evt.update_attribute :event_begin_time, DateTime.new(year, d.month, d.day, b.hour, b.min, b.sec)
      evt.update_attribute :event_finish_time, DateTime.new(year, d.month, d.day, f.hour, f.min, f.sec)
    end

    change_column_null :events, :event_begin_time, false
    change_column_null :events, :event_finish_time, false

    remove_column :events, :date
    remove_column :events, :time
    remove_column :events, :active
  end
end
