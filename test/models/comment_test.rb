require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @commentable = [schools(:one)].sample
    @school = schools(:one)
  end

  test "commentable_type required" do
    c1 = Comment.new(content: "hey", user: @user, commentable: @commentable)
    c2 = Comment.new(content: "hey", user: @user, commentable_id: @commentable.id)
    assert c1.save
    refute c2.save
  end

  test "commentable_id required" do
    c1 = Comment.new(content: "hey", user: @user, commentable: @commentable)
    c2 = Comment.new(content: "hey", user: @user, commentable_type: @commentable.type)
    assert c1.save
    refute c2.save
  end

  test "user_id required" do
    c1 = @commentable.comments.new(content: "hey", user: @user)
    c2 = @commentable.comments.new(content: "hey")
    assert c1.save
    refute c2.save
  end

  test "content can't be blank" do
    c1 = @commentable.comments.new(user: @user, content: nil)
    c2 = @commentable.comments.new(user: @user, content: "")
    c3 = @commentable.comments.new(user: @user, content: " ")
    c4 = @commentable.comments.new(user: @user, content: "  ")
    c5 = @commentable.comments.new(user: @user, content: "hi")
    refute c1.save
    refute c2.save
    refute c3.save
    refute c4.save
    assert c5.save
  end

  test "replies" do
    c1 = @commentable.comments.create(user: @user, content: "cruz")
    c2 = @commentable.comments.create(user: @user, content: "is", original_comment_id: c1.id)
    c3 = @commentable.comments.create(user: @user, content: "the", original_comment_id: c1.id)
    c4 = @commentable.comments.create(user: @user, content: "best", original_comment_id: c1.id)
    assert_equal 3, c1.replies.count
    assert (c1.replies - [c2, c3, c4]).empty?
  end
end
