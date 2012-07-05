# == Schema Information
#
# Table name: assets
#
#  id                :integer         not null, primary key
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  attachable_id     :integer
#  attachable_type   :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Asset < ActiveRecord::Base
  has_attached_file :data,
    :styles => { :small => "150x150>" },
    :url  => "/assets/:id",
    :path => ":rails_root/assets/attachments/:id/:style/:basename.:extension"

  attr_protected :data_file_name, :data_content_type, :data_file_size

  belongs_to :attachable, :polymorphic => true
  
  def url(*args)
    data.url(*args)
  end
  
  def name
    data_file_name
  end
  
  def content_type
    data_content_type
  end
  
  def file_size
    data_file_size
  end
end

