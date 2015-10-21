require 'test_helper'
require 'minitest/pride'

class SchoolTest < ActiveSupport::TestCase
  test "name" do
    school = School.new(name: 'name')
    assert school.save
  end

  test "rating" do
    school = School.create(name: 'name', rating: 90)
    assert_equal 90, school.rating
  end

  test "link" do
    refute = School.new(name: 'name', link: 'link').save
    assert = School.new(name: 'name', link: 'http://google.com').save
    assert = School.new(name: 'name', link: 'https://google.com').save
    assert = School.new(name: 'name', link: 'http://www.google.com').save
    assert = School.new(name: 'name', link: 'https://www.google.com').save

    array = ["http://www.appstate.edu/", "https://www.barton.edu/",
      "http://belmontabbeycollege.edu/", "http://www.campbell.edu/",
      "http://www.davidson.edu/", "https://duke.edu/", "http://www.ecu.edu/",
      "http://www.elon.edu/home/", "http://www.guilford.edu/",
      "http://www.highpoint.edu/", "http://www.jcsu.edu/",
      "https://www.jwu.edu/charlotte/", "http://www.lr.edu/",
      "http://www.meredith.edu/", "https://www.ncsu.edu/",
      "http://www.queens.edu/", "http://www.salem.edu/", "http://www.unc.edu/",
      "http://www.uncc.edu/", "https://www.uncg.edu/", "http://uncw.edu/",
      "http://www.wfu.edu/", "http://www.wingate.edu/"
    ]
    array.each{ |link| assert School.new(name: 'name', link: link).save }
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
    assert school.save
  end

  test "city" do
    school = School.new(name: 'name', city: 'city')
    assert school.save
  end

  test "state" do
    school = School.new(name: 'name', state: 'state')
    assert school.save
  end

  test "zip" do
    school1 = School.new(name: 'name', zip: '1234')
    school2 = School.new(name: 'name', zip: '12345')
    school3 = School.new(name: 'name', zip: '123456')
    school4 = School.new(name: 'name', zip: '12345-789')
    school5 = School.new(name: 'name', zip: '12345-7890')
    school6 = School.new(name: 'name', zip: '12345-78901')
    refute school1.save
    assert school2.save
    refute school3.save
    refute school4.save
    assert school5.save
    refute school6.save
  end

  test "public" do
    school = School.new(name: 'name', public: true)
    assert school.save
  end

  test "address" do
    school1 = School.create(name: 'name', street: "one", city: "two", state: "three", zip: "39902")
    school2 = School.create(name: 'name', street: "one", city: "two", state: "three")
    assert_equal 'one, two, three 39902', school1.address
    assert_nil school2.address
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
