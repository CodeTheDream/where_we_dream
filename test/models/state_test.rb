require 'test_helper'

class StateTest < ActiveSupport::TestCase
  setup do
    @state = states(:one)
  end

  test "name required" do
    s1 = State.new(abbreviation: "NC")
    s2 = State.new(abbreviation: "NC", name: "name")
    refute s1.save
    assert s2.save
  end

  test "abbreviation required" do
    s1 = State.new(name: "name")
    s2 = State.new(name: "name", abbreviation: "NC")
    refute s1.save
    assert s2.save
  end

  test "schools method" do
    assert_equal 1, @state.schools.count
  end
end
