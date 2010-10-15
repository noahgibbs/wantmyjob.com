class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :jobs

  def next_question
    last_perfect = Answer.last_perfect_answer.for_profile_id(id)
    last_co = Answer.last_company_answer.for_profile_id(id)

    # For now, just simple greater-than.  We'll need to do
    # something better when we have perfect-only and company-
    # only question types.

    use_perfect = last_perfect.id <= last_co.id

    if use_perfect
      template = :ask_perfect
      @company_name = "your perfect job"
    else
      template = :ask_company
      @company_name = work_site.checked_company_name
    end

    render :action => template
  end
end
