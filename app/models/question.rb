class Question < ActiveRecord::Base
  has_many :question_answers, :dependent => :destroy,
           :autosave => true
  has_many :answers

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

  scope :random_order, order("RAND()")
  scope :verified, where(:verified => true, :completed => true,
                         :soft_deleted => false)

  # This is actually done by answer type, not question type.  It
  # returns a Question, though, so it winds up having to be a
  # scope on Question, not Answer.

  # This is going to be *SO SLOW*.  But I'll optimize after I know
  # better what a right answer will look like.
  scope :next_perfect_company_question_for_profile lambda {|profile|
    joins("LEFT JOIN " +
          "(select * from answers WHERE " +
            "answer_type = #{Answer::PERFECT_COMPANY_ANSWER} AND " +
            "profile_id = #{profile.id.to_i}) AS a " +
          "ON questions.id = a.question_id").
    where("a.answer_type IS NULL").
    order("questions.id")
  }

end
