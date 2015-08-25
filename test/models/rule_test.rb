require 'test_helper'

class RuleTest < ActiveSupport::TestCase
  setup do
    @school = schools(:one)
    @question = questions(:one)
  end

  test "school" do
    rule = Rule.new(school: @school, question: @question)
    assert rule.save
    assert_equal @school.id, rule.school.id
    assert_equal @question.id, rule.question.id
    assert_equal "MyString", rule.question!
  end

  test "answer" do
    rule = Rule.create(school: @school, question: @question)
    rule.answer = true
    assert_equal true, rule.answer
    rule.answer = false
    assert_equal false, rule.answer
  end

  test "school has many answers" do
    rule1 = Rule.create(school: @school, question: @question, answer: true)
    rule2 = Rule.create(school: @school, question: @question, answer: false)
    rule3 = Rule.create(school: @school, question: @question, answer: false)

    @school.rules << [rule1, rule2, rule3]
    assert_equal 3, @school.rules.count

    assert_equal [true, false, false], @school.rules.map(&:answer)
  end
end
