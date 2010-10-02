class RegistrationsController < ApplicationController
  def quick
    @profile = Profile.new
  end
end
