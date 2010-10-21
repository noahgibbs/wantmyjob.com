class Answer < ActiveRecord::Base
  belongs_to :profile
  belongs_to :job
  belongs_to :question

  NUM_DATA_FIELDS = 4

  # There are many fine Answer Types, which correspond
  # only somewhat to question types.  For instance,
  # an EMPLOYER_QUESTION can be answered with a
  # COMPANY_ANSWER or a PERFECT_COMPANY_ANSWER.

  COMPANY_ANSWER = 1
  PERFECT_COMPANY_ANSWER = 2

  scope :for_profile_id, lambda {|pid| where(:profile_id => pid)}
  scope :for_company_id, lambda {|cid| where(:company_id => cid)}

end
