class CreateGroupMembers < ActiveRecord::Migration
  def self.up
    create_table :group_members do |t|
      t.integer :user_id, :null => false
      t.integer :group_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :group_members
  end
end
