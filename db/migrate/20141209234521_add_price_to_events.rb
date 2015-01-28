class AddPriceToEvents < ActiveRecord::Migration
  def change
    add_column :events, :price, :decimal, :precision => 8, :scale => 2

    Event.all.each do |evt|
      evt.update_attribute :price, 0.00 unless evt.price?
    end
  end
end
