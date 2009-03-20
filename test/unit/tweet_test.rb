require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  test "from user scope" do
    assert_equal 1, Tweet.from_users([3541296]).size
  end
end
