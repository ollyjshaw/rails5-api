require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should save a user" do
    u = User.new(name: "Olly")
    assert u.save
    assert_equal "Olly", u.name
  end

  test "using raises" do
    err = assert_raises(ActiveRecord::RecordInvalid) do
      u = User.new
      u.save!
    end
    assert_equal "Validation failed: Name can't be blank", err.message
  end

end
