require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email required" do
    u1 = User.new(first_name: "name", user_type: "Student", password: "passwo")
    u2 = User.new(first_name: "name", user_type: "Student", password: "passwo", email: "a@a.a")
    refute u1.save
    assert u2.save
  end

  test "email uniqueness" do
    u1 = User.new(first_name: "name", user_type: "Student", password: "passwo", email: "a@a.a")
    u2 = User.new(first_name: "name", user_type: "Student", password: "passwo", email: "a@a.a")
    assert u1.save
    refute u2.save
  end

  test "password required" do
    u1 = User.new(first_name: "name", user_type: "Student", email: "a@a.a")
    u2 = User.new(first_name: "name", user_type: "Student", email: "a@a.a", password: "passwo")
    refute u1.save
    assert u2.save
  end

  test "password length" do
    u1 = User.new(first_name: "name", user_type: "Student", email: "a@a.a", password: "short")
    u2 = User.new(first_name: "name", user_type: "Student", email: "a@a.a", password: "6chars")
    u3 = User.new(first_name: "name", user_type: "Student", email: "a@a.a1", password: "twenty(20)characters")
    u4 = User.new(first_name: "name", user_type: "Student", email: "a@a.a2", password: "wayyyyy tooo looonggg")
    refute u1.save
    assert u2.save
    assert u3.save
    refute u4.save
  end

  test "user_type required" do
    u1 = User.new(first_name: "name", email: "a@a.a", password: "passwo")
    u2 = User.new(first_name: "name", email: "a@a.a", password: "passwo", user_type: "Student")
    refute u1.save
    assert u2.save
  end

  test "first_name required" do
    u1 = User.new(email: "a@a.a", password: "passwo", user_type: "Student")
    u2 = User.new(email: "a@a.a", password: "passwo", user_type: "Student", first_name: "name")
    refute u1.save
    assert u2.save
  end
end
