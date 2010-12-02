class Question < ActiveRecord::Base
  has_many :question_answers, :dependent => :destroy,
           :autosave => true
  has_many :answers

  attr_accessible :question_type, :text

  MAX_ANSWERS = 5

  # Question types define how the Question object and its
  # associated QuestionAnswers can be answered.  However,
  # more than one question type can potentially be answered
  # in a given way (as a "perfect company" question, say),
  # and just generally the question-object type may be
  # different than the answer-object type.
  # For that reason among others, there can be multiple
  # valid sets of answers to a given single question -- For
  # instance, an EMPLOYER_QUESTION has one for each company
  # you worked for, plus one "perfect company" answer.

  # An Employer question can be about a previous employer,
  # or about your perfect company to work for.
  EMPLOYER_QUESTION = 1

  # A Workplace question can be asked about a previous employer,
  # but won't be asked about your perfect company.
  WORKPLACE_QUESTION = 2

  scope :verified, where(:verified => true, :completed => true)
  scope :unverified, where(:verified => false)

  def text_for(employer_name)
    text.gsub("<company>", employer_name)
  end

end
