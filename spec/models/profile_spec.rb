require 'spec_helper'

describe Profile do
  its(:next_question) { should == [nil, nil, nil] }
end

describe "a profile with one job" do
  subject { j = Factory.create(:job); j.profile }

  context "with one question and no answers" do
    let(:question) { Factory.create(:question) }

    its(:next_question) { should include(question) }
  end

  context "with one question and a perfect company answer" do
    let(:question) { Factory.create(:question) }
    let(:answer) { Factory.create(:answer, :question_id => question.id,
                                  :profile_id => subject.id,
                                  :data1 => 7, :data2 => 155) }

    its(:next_question) { should include(question, Answer::COMPANY_ANSWER) }
  end
end
