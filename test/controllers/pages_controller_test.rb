require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get schools" do
    get :schools
    assert_response :success
  end

  test "should get students" do
    get :students
    assert_response :success
  end

  test "should get scholarships" do
    get :scholarships
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get FAQs" do
    get :faqs
    assert_response :success
  end

  test "should get wait" do
    get :wait
    assert_response :success
  end
end
