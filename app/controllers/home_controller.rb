class HomeController < ApplicationController
  def index
    @big_logo = true
  end

  # Where to next on the site...
  def portal
    unless current_user.profile
      # Make a new empty profile for the user
      current_user.create_profile
      current_user.save!
      current_user.profile.save!
    end

    # Check to see if the user has entered any current jobs

    raise "Unimplemented"
  end
end
