class Rule < ActiveRecord::Base
  belongs_to :school
  belongs_to :question

  validates_presence_of :school, :question

  def question!
    self.question.value
  end

  def no_answer?
    answer == nil
  end

  def answer!
    {true => "Yes", false => "No", nil => "Unknown"}[answer]
  end
end
