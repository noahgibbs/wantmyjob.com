class Answer < ActiveRecord::Base
  belongs_to :job
  belongs_to :question

  # There are many fine Answer Types, which correspond
  # only somewhat to question types.  For instance,
  # an EMPLOYER_QUESTION can be answered as a
  # COMPANY_ANSWER or a PERFECT_COMPANY_ANSWER.

  COMPANY_ANSWER = 1
  PERFECT_COMPANY_ANSWER = 2

  def profile_id
    job.profile_id
  end

  def profile
    job.profile
  end
end
