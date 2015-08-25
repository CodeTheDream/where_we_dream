require 'test_helper'

class Admin::QuestionsControllerTest < ActionController::TestCase
  setup do
    # @controller = Admin::QuestionsController
    @question = questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post :create, question: { value: @question.value }
    end

    assert_redirected_to admin_questions_path
  end

  test "should show question" do
    get :show, id: @question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question
    assert_response :success
  end

  test "should update question" do
    patch :update, id: @question, question: { value: @question.value }
    assert_redirected_to admin_questions_path
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end

    assert_redirected_to admin_questions_path
  end
end
