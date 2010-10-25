require 'spec_helper'

describe QuestionsController do
  include AppSpecHelpers

  def mock_question(stubs={})
    mock_ar_object("question", stubs)
  end

  describe "GET enter" do
    it "doesn't fail completely" do
      get :enter
    end
  end

  describe "POST enter_post" do
    # Real test goes here

    it "should redirect to the portal" do
      post :enter_post, :jobs => [{}]
      should redirect_to(:controller => :home, :action => :portal)
    end
  end

end
