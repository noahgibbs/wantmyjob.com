module AdminHelper
  def user_to_link(user)
    link_to(user.login, "/users/#{user.id}").html_safe
  end

  def profile_to_link(profile)
    link_to(profile.fullname, "/profiles/#{profile.id}").html_safe
  end

  def job_to_link(job)
    link_to(job.employer, "/jobs/#{job.id}").html_safe
  end
end
