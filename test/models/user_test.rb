require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email required" do
    u1 = User.new(password: "pass")
    u2 = User.new(password: "pass", email: "foo")
    refute u1.save
    assert u2.save
  end

  test "password required" do
    u1 = User.new(email: "foo")
    u2 = User.new(email: "foo", password: "pass")
    refute u1.save
    assert u2.save
  end
end
