class OldPage < ActiveRecord::Base
  validates_presence_of :page_id
  validates_presence_of :path
  validates_presence_of :title
  validates_presence_of :content
end
