class Question < ActiveRecord::Base
  has_many :question_answers, :dependent => :destroy,
           :autosave => true

  MAX_ANSWERS = 5

  # An Employer question can be about a previous employer, or about
  # your perfect company to work for
  EMPLOYER_QUESTION = 1
end
