require 'test_helper'

class OpinionableTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @opinionable = [comments(:one), schools(:one)].sample
  end

  test "type method" do
    assert_equal @opinionable.class.to_s, @opinionable.type
  end

  test "liked_by?(param) method" do
    @opinionable.opinions.create(user_id: @user.id, value: true)
    assert @opinionable.liked_by?(@user)
    assert @opinionable.liked_by?(@user.id)
    refute @opinionable.liked_by?("potato")
  end

  test "disliked_by?(param) method" do
    @opinionable.opinions.create(user_id: @user.id, value: false)
    assert @opinionable.disliked_by?(@user)
    assert @opinionable.disliked_by?(@user.id)
    refute @opinionable.disliked_by?("potato")
  end

  test "likes method" do
    assert_difference "@opinionable.likes" do
      @opinionable.opinions.create(user_id: @user.id, value: true)
    end
  end

  test "dislikes method" do
    assert_difference "@opinionable.dislikes" do
      @opinionable.opinions.create(user_id: @user.id, value: false)
    end
  end
end
