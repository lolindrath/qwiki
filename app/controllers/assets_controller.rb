class AssetsController < ApplicationController
  #before_filter :login_required
  
  def show
    asset = Asset.find(params[:id])

    disposition = ''
    if asset.data_content_type == 'image/gif'
      disposition = 'inline'
    else
      disposition = 'asset'
    end

    send_file asset.data.path, :type => asset.data_content_type, :disposition => disposition
  end

  def destroy
    asset = Asset.find(params[:id])
    @asset_id = asset.id.to_s
    asset.destroy
  end
    
end

