class AddCommunityIdAndSkillIdToSignup < ActiveRecord::Migration
  def change
    add_column :signups, :community, :string, null: false, default: ''
    add_column :signups, :item_id, :integer, null: false
    add_column :signups, :skill_id, :integer, null: false
  end
end
