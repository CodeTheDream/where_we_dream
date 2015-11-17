require 'test_helper'

class StateTest < ActiveSupport::TestCase
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

  test "body required" do
    s1 = @user.stories.new(title: "title", description: "description")
    s2 = @user.stories.new(title: "title", description: "description", body: "body")
    refute s1.save
    assert s2.save
  end
end
