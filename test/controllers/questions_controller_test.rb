require 'test_helper'

class Admin::QuestionsControllerTest < ActionController::TestCase
  setup do
    # @controller = Admin::QuestionsController
    @question = questions(:one)
  end

  def nil_setup
    session[:user_id] = nil
    session[:user_type] = nil
  end

  def viewer_setup
    @viewer = users(:one)
    session[:user_id] = @viewer.id
    session[:user_type] = @viewer.user_type
  end

  def admin_setup
    @admin = users(:two)
    session[:user_id] = @admin.id
    session[:user_type] = @admin.user_type
  end

  def redirected given_path = nil
    notice = given_path ? "Must be logged in" : "ACCESS DENIED"
    assert_redirected_to given_path || root_path
    assert_equal notice, flash[:notice]
  end

  def success
    assert_response :success
  end

  test "logged out" do
    nil_setup
    get :index
    redirected login_path
    get :new
    redirected login_path
  end

  test "viewer logged in" do
    viewer_setup
    get :index
    redirected
    get :new
    redirected
  end

  test "admin logged in" do
    admin_setup
    get :index
    success
    # get :new
    # success
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  #
  # test "should create question" do
  #   assert_difference('Question.count') do
  #     post :create, question: { value: @question.value }
  #   end
  #
  #   assert_redirected_to admin_questions_path
  # end
  #
  # test "should show question" do
  #   get :show, id: @question
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get :edit, id: @question
  #   assert_response :success
  # end
  #
  # test "should update question" do
  #   patch :update, id: @question, question: { value: @question.value }
  #   assert_redirected_to admin_questions_path
  # end
  #
  # test "should destroy question" do
  #   assert_difference('Question.count', -1) do
  #     delete :destroy, id: @question
  #   end
  #
  #   assert_redirected_to admin_questions_path
  # end
end
