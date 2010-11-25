class ApplicationController < ActionController::Base
  protect_from_forgery

  SCAFFOLD_ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]

  def requires_admin
    redirect_to "/" unless current_user.admin || script_run_as_admin
  end

  def script_run_as_admin(new_val = nil)
    @script_run_as_admin = new_val unless new_val.nil?
    @script_run_as_admin
  end

  def malformed_url_error
    render :text => "Bad URL!  Did you paste it wrong, maybe?", :status => 404
  end
end
