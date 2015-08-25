class Rule < ActiveRecord::Base
  belongs_to :school
  belongs_to :question

  validates :school_id, presence: true
  validates :question_id, presence: true

  def question!
    self.question.value
  end
end
