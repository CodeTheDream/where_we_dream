require 'test_helper'

class OpinionTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @comment = comments(:one)
    @school = schools(:one)
  end

  test "opinionable_type required" do
    o1 = Opinion.new(user: @user, opinionable_id: @comment.id, opinionable_type: @comment.type)
    o2 = Opinion.new(user: @user, opinionable_id: @comment.id, opinionable_type: nil)
    assert o1.save
    refute o2.save
  end

  test "opinionable_id required" do
    o1 = Opinion.new(user: @user, opinionable_type: @comment.type, opinionable_id: @comment.id)
    o2 = Opinion.new(user: @user, opinionable_type: @comment.type, opinionable_id: nil)
    assert o1.save
    refute o2.save
  end

  test "user_id required" do
    o1 = Opinion.new(opinionable: @comment, user_id: @user.id)
    o2 = Opinion.new(opinionable: @comment, user_id: nil)
    assert o1.save
    refute o2.save
  end

  test "user likes comment" do
    assert_difference ["@comment.likes","@user.opinions.count"] do
      @comment.opinions.create(user: @user, value: true)
    end
    assert @comment.liked_by?(@user)
    assert @user.likes?(@comment)
  end

  test "user dislikes comment" do
    assert_difference ["@comment.dislikes","@user.opinions.count"] do
      @comment.opinions.create(user: @user, value: false)
    end
    assert @comment.disliked_by?(@user)
    assert @user.dislikes?(@comment)
  end

  test "user likes school" do
    assert_difference ["@school.likes","@user.opinions.count"] do
      @school.opinions.create(user: @user, value: true)
    end
    assert @school.liked_by?(@user)
    assert @user.likes?(@school)
  end

  test "user dislikes school" do
    assert_difference ["@school.dislikes","@user.opinions.count"] do
      @school.opinions.create(user: @user, value: false)
    end
    assert @school.disliked_by?(@user)
    assert @user.dislikes?(@school)
  end

  test "user can only like/dislike one of each thing" do
    c1 = @comment.opinions.new(user: @user, value: true)
    c2 = @comment.opinions.new(user: @user, value: true)
    s1 = @school.opinions.new(user: @user, value: false)
    s2 = @school.opinions.new(user: @user, value: false)
    assert c1.save
    refute c2.save
    assert s1.save
    refute s2.save
  end
end
