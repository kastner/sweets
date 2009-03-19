class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :password
      t.string :terms
      t.text :notes
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
