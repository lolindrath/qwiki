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

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
