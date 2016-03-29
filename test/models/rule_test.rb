require 'test_helper'

class RuleTest < ActiveSupport::TestCase
  setup do
    @school = schools(:one)
    @question = questions(:one)
  end

  test "school_id required" do
    r1 = Rule.new(question: @question, school: @school)
    r2 = Rule.new(question: @question)
    assert r1.save
    refute r2.save
  end

  test "question_id required" do
    r1 = Rule.new(school: @school, question: @question)
    r2 = Rule.new(school: @school)
    assert r1.save
    refute r2.save
  end

  test "school" do
    rule = Rule.create(school: @school, question: @question)
    assert_equal @school, rule.school
  end

  test "question" do
    rule = Rule.create(school: @school, question: @question)
    assert_equal @question, rule.question
  end

  test "answer" do
    rule = Rule.create(school: @school, question: @question)
    rule.answer = true
    assert rule.answer
    rule.answer = false
    refute rule.answer
  end

  test "school has many answers" do
    r1 = @school.rules.create(question: @question)
    r2 = @school.rules.create(question: @question, answer: true)
    r3 = @school.rules.create(question: @question, answer: false)

    assert_equal [r1, r2, r3], @school.rules
  end

  test "question! method" do
    rule = @school.rules.create(question: @question, answer: true)
    assert_equal @question.value, rule.question!
  end

  test "no_answer? method" do
    r1 = @school.rules.create(question: @question)
    r2 = @school.rules.create(question: @question, answer: true)
    assert r1.no_answer?
    refute r2.no_answer?
  end

  test "answer! method" do
    r1 = @school.rules.create(question: @question)
    r2 = @school.rules.create(question: @question, answer: true)
    r3 = @school.rules.create(question: @question, answer: false)
    assert_equal "Unknown", r1.answer!
    assert_equal "Yes", r2.answer!
    assert_equal "No", r3.answer!
  end
end
