class Question < ActiveRecord::Base
  has_many :rules, dependent: :destroy
  validate :actual_question
  validates :value, presence: true

  def actual_question
    unless self.value.include?('?')
      self.value+='?'
    end
  end
end
