require 'spec_helper'

describe Profile do
  its(:next_question) { should == [nil, nil, nil] }
end

describe "a profile with one job" do
  subject { j = Factory.create(:job); j.profile }

  context "and one question and no answers" do
    let(:question) { Factory.create(:question) }

    its(:next_question) { should include(question) }

    it "should have 50% odds of a perfect company question" do
      question # create this
      questions, answers, odds = subject.next_question_odds
      (odds - 0.5).abs.should < 0.0001
    end
  end

  context "and one question and a perfect company answer" do
    let(:question) { Factory.create(:question) }
    let(:answer) { Factory.create(:answer, :question_id => question.id,
                                 :answer_type => Answer::PERFECT_COMPANY_ANSWER,
                                  :profile_id => subject.id,
                                  :data1 => 7, :data2 => 155) }

    it "should have 0% odds of a perfect-company-answer next" do
      question; answer
      qs, as, odds = subject.next_question_odds
      (odds - 1.0).abs.should <= 0.0001
    end

    it "should try for a company-answer next" do
      question; answer  # Make sure both are created
      subject.next_question.should include(question, Answer::COMPANY_ANSWER)
    end

    it "should see exactly one question and one answer" do
      question; answer  # Make sure both are created
      # This is mostly testing the test suite
      Question.count.should == 1
      Question.verified.count.should == 1
      Answer.count.should == 1
    end
  end
end
