# == Schema Information
#
# Table name: pages
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  body         :text
#  user_id      :integer
#  edit_summary :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Page < ActiveRecord::Base
  has_many :assets, :as => :attachable, :dependent => :destroy
  belongs_to :user


  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name, :body, :user
  validates_format_of :name, :with => /[\w ]+/, :on => :create

  versioned
end
