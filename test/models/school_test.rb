require 'test_helper'
require 'minitest/pride'

class SchoolTest < ActiveSupport::TestCase
  test "name" do
    school = School.new(name: 'name')
    assert school.save
  end

  test "link" do
    school = School.new(name: 'name', link: 'link')
    assert school.save
  end

  test "students" do
    school1 = School.new(name: 'name', students: 'seven')
    school2 = School.new(name: 'name', students: 10)
    refute school1.save
    assert school2.save
  end

  test "undocumented_students" do
    school1 = School.new(name: 'name', undocumented_students: 'seven')
    school2 = School.new(name: 'name', undocumented_students: 10)
    refute school1.save
    assert school2.save
  end

  test "street" do
    school = School.new(name: 'name', street: 'street')
    school.save
  end

  test "city" do
    school = School.new(name: 'name', city: 'city')
    school.save
  end

  test "state" do
    school = School.new(name: 'name', state: 'state')
    school.save
  end

  test "zip" do
    school1 = School.new(name: 'name', zip: '1234')
    school2 = School.new(name: 'name', zip: '12345')
    school3 = School.new(name: 'name', zip: '123456')
    refute school1.save
    assert school2.save
    refute school3.save
  end

  test "public" do
    school = School.new(name: 'name', public: true)
    assert school.save
  end

  test "address" do
    school1 = School.create(name: 'name', street: "one", city: "two", state: "three", zip: "39902")
    school2 = School.create(name: 'name', street: "one", city: "two", state: "three")
    assert school2.zip.blank?
    assert_equal 'one, two, three 39902', school1.address
    assert_equal nil, school2.address
  end

  test "rules" do
    school = School.create(name: 'school')
    question = Question.create(value: 'sup?')

    assert_equal 0, school.rules.count

    rule1 = Rule.create(school: school, question: question, answer: true)
    rule2 = Rule.create(school: school, question: question, answer: false)
    rule3 = Rule.create(school: school, question: question, answer: false)

    assert_equal 3, school.rules.count
  end

  test "nested rules" do
    school = School.create(name: 'school')
    question = Question.create(value: 'sup?')

    assert_equal 0, school.rules.count

    school.rules.new(school: school, question: question, answer: true)

    assert_difference 'school.rules.count' do
      school.save
    end
  end

  test "nested rules 2" do
    school = School.create(name: 'school')

    assert_equal 0, school.rules.count

    Question.all.each do |question|
      school.rules.new(question: question)
    end

    assert_difference 'school.rules.count', 3 do # the '3' come from the fixtures
      school.save
    end
  end

  test "delete" do
    school = School.create(name: 'school')

    Question.all.each do |question| # Already 2 rules from fixtures but makes three more rules
      school.rules.new(question: question)
    end

    school.save

    assert_equal 5, Rule.count

    School.destroy(school.id) # only 3 rules were associated with this school so 5 - 3 = 2

    assert_equal 2, Rule.count
  end
end
