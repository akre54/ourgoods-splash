class AddPaidToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :paid, :bool, default: false
    add_column :signups, :stripe_token, :string
  end
end
