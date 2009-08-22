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
    page3 = Page.new(:title => 'トップページ',
                    :path => 'top',
                    :content => "!!Wikiへようこそ\n(ここがサイトの表紙になります)")
    page3.save
  end

  def self.down
    Page.delete_all(["path=? or path=? or path=?", 'about', 'menu', 'top'])
  end
end
