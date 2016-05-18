require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "users can be called" do
    user = users(:one)
    assert user.valid?
  end
end
