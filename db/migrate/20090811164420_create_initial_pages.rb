class CreateInitialPages < ActiveRecord::Migration
  def self.up
    page = Page.new(:title => 'このサイトについて',
                    :path => 'about',
                    :content => '(サイトの紹介を更新してください)')
    page.save
    page2 = Page.new(:title => 'メニュー',
                     :path => 'menu',
                     :content => "*[[about]]\n*[[menu]]")
    page2.save
  end

  def self.down
    Page.delete_all(["path=? or path=?", 'about', 'menu'])
  end
end
