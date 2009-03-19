class AddTemplatesToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :page_template, :text
    add_column :projects, :tweet_template, :text
  end

  def self.down
    remove_column :projects, :tweet_template
    remove_column :projects, :page_template
  end
end
