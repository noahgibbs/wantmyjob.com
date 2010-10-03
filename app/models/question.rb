class Question < ActiveRecord::Base
  has_many :question_answers
end
