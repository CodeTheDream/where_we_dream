class Rule < ActiveRecord::Base
  belongs_to :school
  belongs_to :question

  validates :school_id, presence: true
  validates :question_id, presence: true

  def question!
    self.question.value
  end

  def no_answer?
    answer == nil
  end

  def answer!
    case answer
    when true
      "Yes"
    when false
      "No"
    when nil
      "Unknown"
    end
  end
end
