require 'spec_helper'

describe QuestionsController do
  include AppSpecHelpers

  describe "GET enter" do
    it "doesn't fail completely" do
      get :enter
    end
  end

  describe "POST enter_post" do
    it "should redirect to entering questions" do
      post :enter_post, :jobs => [{}]
      should redirect_to(:controller => :questions, :action => :enter)
    end
  end

  describe "GET answer" do
    let(:profile) { Factory(:profile) }

    before do
      mock_user.stub(:profile) { profile }
      profile.stub(:next_question) { [nil, nil, nil] }
    end

    it "redirects to enter questions if no next question is found" do
      get :answer
      should redirect_to(:action => :enter)
    end
  end

  describe "POST answer_post" do
    let(:profile) { Factory(:profile) }

    before do
      mock_user.stub(:profile) { profile }
    end

    it "redirects to the portal with no sub-keys" do
      ans = mock_model(Answer)
      Answer.should_receive(:new).once.with("data1" => 271, "data2" => 35,
          "data3" => 0, "data4" => 0, "profile_id" => 7,
          "answer_type" => 1, "question_id" => 4,
          "job_id" => 6).and_return(ans)
      ans.should_receive(:save!).once
      post :answer_post,
        :answer => { :data1 => "271", :data2 => "35", :data3 => "",
                     :data4 => "0", :profile_id => 7,
                     :answer_type => 1, :question_id => 4, :job_id => 6 }
      response.should be_redirect
    end

    it "works properly with sub-keys and bad data" do
      ans = mock_model(Answer)
      Answer.should_receive(:new).once.with("data1" => 0, "data2" => 37,
          "data3" => 0, "data4" => 0, "profile_id" => 7,
          "answer_type" => 1, "question_id" => 4,
          "job_id" => 6).and_return(ans)
      ans.should_receive(:save!).once
      post :answer_post,
        :answer => { :data1 => "ab", :data2_1 => "11", :data2_2 => "7",
                     :data2_7 => "19", :data3 => nil,
                     :data4 => "0", :profile_id => 7,
                     :answer_type => 1, :question_id => 4, :job_id => 6 }
      response.should be_redirect
    end
  end

end
