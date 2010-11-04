class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :requires_admin

  ["profile", "user", "question", "job"].each do |item|
    expose(("new_" + item + "s").to_sym) do
      klass = Object.const_get(item.capitalize)
      klass.where("created_at > ?", Time.now - 24.hours)
    end
  end

  expose(:questions_to_approve) { Question.unverified }

  def console
  end
end
