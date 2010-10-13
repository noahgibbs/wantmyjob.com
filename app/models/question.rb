class Question < ActiveRecord::Base
  has_many :question_answers

  MAX_ANSWERS = 5

  PREVIOUS_EMPLOYER_QUESTION = 1
  PERFECT_COMPANY_QUESTION = 2
end
