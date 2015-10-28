require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "title required" do
    s1 = @user.stories.new(description: "description", body: "body")
    s2 = @user.stories.new(description: "description", body: "body", title: "title")
    refute s1.save
    assert s2.save
  end

  test "description required" do
    s1 = @user.stories.new(title: "title", body: "body")
    s2 = @user.stories.new(title: "title", body: "body", description: "description")
    refute s1.save
    assert s2.save
  end

  test "body required" do
    s1 = @user.stories.new(title: "title", description: "description")
    s2 = @user.stories.new(title: "title", description: "description", body: "body")
    refute s1.save
    assert s2.save
  end

  test "user required" do
    s1 = Story.new(title: "title", description: "description", body: "body")
    s2 = @user.stories.new(title: "title", description: "description", body: "body")
    refute s1.save
    assert s2.save
  end
end
