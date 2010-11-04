class MatchesController < ApplicationController
  before_filter :authenticate_user!

  expose(:match) do
    current_user.current_profile.utterly_naive_matches.find(params[:id])
  end

  def show
  end
end
