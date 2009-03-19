class CreateFilters < ActiveRecord::Migration
  def self.up
    create_table :filters do |t|
      t.integer :project_id
      t.integer :from_user_id
      t.integer :twitter_id
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :filters
  end
end
