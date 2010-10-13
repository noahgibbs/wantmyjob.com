class ApplicationController < ActionController::Base
  protect_from_forgery

  SCAFFOLD_ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]

  def requires_admin
  end
end
