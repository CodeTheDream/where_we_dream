class Question < ActiveRecord::Base
  validate :actual_question
  validates :value, presence: true

  def actual_question
    unless self.value.include?('?')
      self.value+='?'
    end
  end
end
