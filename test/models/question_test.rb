require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "values" do
    question = Question.new(value:'hey')
    assert question.save
    assert_equal 'hey?', question.value
  end
end
