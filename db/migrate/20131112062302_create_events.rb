class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :date
      t.string :time
      t.string :venue
      t.string :address

      t.timestamps
    end

    add_column :signups, :event_id, :integer

    event = Event.create({
      title: 'Asset Mapping For Artists',
      date: 'Tuesday, December 17th',
      time: '6:30-8:30pm',
      venue: 'New York Live Arts',
      address: '219 W 19th St (btw 7th and 8th Aves)',
    })

    Signup.all.each do |signup|
      signup.update_attribute(:event_id, event.id)
    end
  end
end
