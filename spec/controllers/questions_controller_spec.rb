require 'spec_helper'
require 'devise/test_helpers'

describe QuestionsController do
  include Devise::TestHelpers

  before(:each) do
    # mock up an authentication in the underlying warden library
    request.env['warden'] = mock(Warden, :authenticate => mock_user,
                                 :authenticate! => mock_user)
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  def mock_question(stubs={})
    (@mock_question ||= mock_model(Question).as_null_object).tap do |question|
      question.stub(stubs) unless stubs.empty?
    end
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
