class AddCommunityIdAndSkillIdToSignup < ActiveRecord::Migration
  def change
    add_column :signups, :community, :string, null: false, default: ''
    add_column :signups, :item_id, :integer,  null: true
    add_column :signups, :skill_id, :integer, null: true
  end
end
