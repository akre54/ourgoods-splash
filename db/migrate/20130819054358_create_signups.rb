class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :name
      t.string :email
      t.integer :have_id
      t.integer :need_id

      t.timestamps
    end
    create_table :barterables do |t|
      t.string :description

      t.timestamps
    end
    add_index :signups, :email
  end
end
