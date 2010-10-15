class Question < ActiveRecord::Base
  has_many :question_answers, :dependent => :destroy,
           :autosave => true

  MAX_ANSWERS = 5

  # Question types define how the Question object and its
  # associated QuestionAnswers can be answered.  However,
  # more than one question type can potentially be answered
  # in a given way (as a "perfect company" question, say),
  # and just generally the question-object-type may be
  # different than the what-kind-of-question-is-asked type.
  # For that reason among others, there can be multiple
  # valid sets of answers to a given single question -- For
  # instance, one for each company you worked for, plus
  # one "perfect company" answer, plus maybe others.

  # An Employer question can be about a previous employer,
  # or about your perfect company to work for.
  EMPLOYER_QUESTION = 1
end
