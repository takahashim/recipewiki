class Page < ActiveRecord::Base
  validates_presence_of :path
  validates_presence_of :title
  validates_presence_of :content

  attr_accessor :password

  def before_save
    logger.info 'hoge'
    old_page = OldPage.new
    old_page.page_id = self.id
    old_page.page_title = self.title
    old_page.page_path = self.path
    old_page.page_content = self.content
    old_page.page_created_at = self.created_at
    old_page.page_updated_at = self.updated_at
    logger.info self.path
    old_page.save!
    true
  end
end
