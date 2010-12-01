class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :requires_admin

  respond_to :html

  ["profile", "user", "question", "job"].each do |item|
    expose(("new_" + item + "s").to_sym) do
      klass = Object.const_get(item.capitalize)
      klass.where("created_at > ?", Time.now - 24.hours)
    end
  end

  expose(:questions_to_approve) { Question.unverified }
  expose(:users) { User.all }

  def become_user
    return unless current_user.admin?  # Duplicate check
    user = User.find(params[:user_id])
    sign_in(:user, user)
    flash[:notice] = "Logged in as #{user.login}"
    redirect_to :controller => :home, :action => :index
  end
end
