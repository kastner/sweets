class AddIndexToTweetsOnUsername < ActiveRecord::Migration
  def self.up
    add_index :tweets, :from_user
  end

  def self.down
    remove_index :tweets, :from_user
  end
end
