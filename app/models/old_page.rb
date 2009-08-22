class OldPage < ActiveRecord::Base
  validates_presence_of :page_id
  validates_presence_of :page_path
  validates_presence_of :page_title
  validates_presence_of :page_content
end
