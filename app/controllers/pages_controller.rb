class PagesController < ApplicationController

  require 'hikidoc'
  before_filter :load_side_info

  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.find(:all, :order=>'updated_at desc', :limit => 100)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find_by_path(params[:path])

    if !@page
      redirect_to new_page_path(params)
      return
    end
    
    @title = @page.title
    @content = HikiDoc.to_html(@page.content)
  end


  def source
    @page = Page.find_by_path(params[:path])

    if !@page
      redirect_to new_page_path(params)
      return
    end
    
    content = @page.content
    response.headers['Content-type'] = 'text/plain; charset=utf-8'
    render :text => content
  end


  # GET /pages/new
  # GET /pages/new.xml
  def new
    title = params[:title] || params[:path]
    @page = Page.new(:title => title, :path=>params[:path])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to show_page_path(@page.path) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to(show_page_path(@page.path)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end

  private
  def load_side_info
    menu = Page.find_by_path('menu')
    @menu = HikiDoc.to_html(menu.content)
    about = Page.find_by_path('about')
    @about = HikiDoc.to_html(about.content)
    update_list = Page.find(:all, :order=>'updated_at desc', :limit => 10)
    @update_list = update_list.collect{|l| "<li><a href=\"#{show_page_path(l.path)}\">#{l.title}</a> #{l.updated_at.localtime.strftime("%Y/%m/%d %H:%M:%S")}</li>\n"}.to_s
  end
end
