class CreateOldPages < ActiveRecord::Migration
  def self.up
    create_table :old_pages do |t|
      t.integer :page_id
      t.string :title
      t.string :path
      t.text :content
      t.datetime :page_created_at
      t.datetime :page_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :old_pages
  end
end
