class AddFromUserToFilters < ActiveRecord::Migration
  def self.up
    add_column :filters, :from_user, :string
  end

  def self.down
    remove_column :filters, :from_user
  end
end
