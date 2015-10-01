require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @comment = comments(:one)
  end

  test "user likes comment" do
    like = @comment.likes.new(user_id: @user.id, value: true)
    assert_difference ["@comment.likes.count","@user.likes.count"] do
      like.save
    end
    assert_equal "Comment", like.likable_type
    assert_equal @comment.id, like.likable_id
  end

  test "user has many likes" do
    like = @user.likes.new(user_id: @user.id, value: true)

  end

  test "comment has many likes" do

  end
end
