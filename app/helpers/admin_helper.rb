module AdminHelper
  def user_to_link(user)
    link_to(user.login, user)
  end

  def profile_to_link(profile)
    link_to(profile.fullname, profile)
  end

  def job_to_link(job)
    link_to(job.employer, job)
  end
end
