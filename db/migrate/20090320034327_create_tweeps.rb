class CreateTweeps < ActiveRecord::Migration
  def self.up
    create_table :tweeps do |t|
      t.integer :project_id
      t.integer :tweet_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tweeps
  end
end
