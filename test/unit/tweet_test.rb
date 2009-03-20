require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  test "from user scope" do
    assert_equal 1, Tweet.from_users(['TiffanySchmidt']).size
  end
end
