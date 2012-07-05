class HistoryController < ApplicationController
  def show
    @page = Page.find(params[:id])
    @page_versions = @page.versions
  end

  def diff
    @page = Page.find(params[:id])
    @page.revert_to(params[:v1].to_i)
    @v1_num = @page.version
    @v1 = @page.body.clone
    @page.revert_to(params[:v2].to_i)
    @v2_num = @page.version
    @v2 = @page.body.clone
  end
end
