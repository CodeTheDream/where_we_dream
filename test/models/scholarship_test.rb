require 'test_helper'

class ScholarshipTest < ActiveSupport::TestCase
  test "name required" do
    s1 = Scholarship.new(amount: 5, deadline: DateTime.now, requirements: "apply")
    s2 = Scholarship.new(amount: 5, deadline: DateTime.now, requirements: "apply", name: "name")
    refute s1.save
    assert s2.save
  end

  test "requirements required" do
    s1 = Scholarship.new(amount: 5, deadline: DateTime.now, name: "name")
    s2 = Scholarship.new(amount: 5, deadline: DateTime.now, name: "name", requirements: "apply")
    refute s1.save
    assert s2.save
  end

  test "amount or full_ride required" do
    s1 = Scholarship.new(name: "name", requirements: "apply", deadline: DateTime.now)
    s2 = Scholarship.new(name: "name", requirements: "apply", deadline: DateTime.now, full_ride: true)
    s3 = Scholarship.new(name: "name", requirements: "apply", deadline: DateTime.now, amount: 5)
    refute s1.save
    assert s2.save
    assert s3.save
  end

  test "deadline required" do
    s1 = Scholarship.new(name: "name", requirements: "apply", amount: 5)
    s2 = Scholarship.new(name: "name", requirements: "apply", amount: 5, deadline: DateTime.now)
    s3 = Scholarship.new(name: "name", requirements: "apply", amount: 5, deadline: DateTime.yesterday)
    refute s1.save
    assert s2.save
    assert s3.save
  end
end
