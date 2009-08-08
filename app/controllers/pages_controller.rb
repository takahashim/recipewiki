class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    require 'hikidoc'
    if params[:path]
      @page = Page.find_by_path(params[:path])
    else
      @page = Page.find(params[:id])
    end

    if !@page
      redirect_to new_page_path(params)
      return
    end
    
    @title = @page.title
    @content = HikiDoc.to_html(@page.content)
  end


  def source
    if params[:path]
      @page = Page.find_by_path(params[:path])
    else
      @page = Page.find(params[:id])
    end

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
        format.html { redirect_to(@page) }
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
        format.html { redirect_to(@page) }
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
end
