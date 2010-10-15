class Answer < ActiveRecord::Base
  belongs_to :job
  belongs_to :question

  # There are many fine Answer Types, which correspond
  # only somewhat to question types.  For instance,
  # an EMPLOYER_QUESTION can be answered with a
  # COMPANY_ANSWER or a PERFECT_COMPANY_ANSWER.

  COMPANY_ANSWER = 1
  PERFECT_COMPANY_ANSWER = 2

  scope :for_profile_id, lambda {|pid| where(:profile_id => pid)}
  scope :for_company_id, lambda {|cid| where(:company_id => cid)}

  scope :last_answer, lambda {|ans_type|
    where(:answer_type => ans_type).
      order("question_id DESC, company_id ASC").
      limit(1)
  }

  def self.last_perfect_answer
    last_answer(PERFECT_COMPANY_ANSWER)
  end

  def self.last_company_answer
    last_answer(COMPANY_ANSWER)
  end

  def profile_id
    job.profile_id
  end

  def profile
    job.profile
  end

end
