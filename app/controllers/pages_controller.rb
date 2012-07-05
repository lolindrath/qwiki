class PagesController < ApplicationController
  before_filter :login_required
  
  def index
    redirect_to :action => :show, :id => 'HomePage'
  end

  def show
    # first try numerical id
    @page = Page.find(:first, :conditions => ['id = ?', params[:id]])

    # next search for page name
    @page ||= Page.find(:first, :conditions => ['LOWER(name) = ?', params[:id].downcase])

    # default to a new page
    if @page.nil?
      redirect_to :action => :new, :id => params[:id]
    else
      @original_page = @page
      if !params[:version].nil?
        @page.revert_to(params[:version].to_i)
      end
    end
  end

  def new
    @page = Page.new
    @page.name = params[:id]

    render :layout => 'edit'
  end

  # POST /pages
  def create
    @page = Page.new(params[:page])
    @page.user = current_user

    process_file_uploads(@page)

    if @page.save
      flash[:notice] = 'Page successfully created.'
      redirect_to(@page)
    else
      render :action => 'new'
    end
  end

  # GET /pages/1/edit
  def edit
    # first try numerical id
    @page = Page.find(:first, :conditions => ['id = ?', params[:id]])

    # next search for page name
    @page ||= Page.find(:first, :conditions => ['LOWER(name) = ?', params[:id].downcase])

    render :layout => 'edit'
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    process_file_uploads(@page)

    @page.user = current_user

    if @page.update_attributes(params[:page])
      flash[:notice] = 'Page was successfully updated.'
      redirect_to(@page)
    else
      render :action => :edit
    end
  end

  def all
    @pages = Page.all :order => 'name ASC'
  end

  protected

  def process_file_uploads(page)
    i = 0
    while !params[:attachment].nil? && !params[:attachment]['file_'+i.to_s].nil? && params[:attachment]['file_'+i.to_s] != ""
      page.assets.build(:data => params[:attachment]['file_'+i.to_s])
      i += 1
    end
  end

end
