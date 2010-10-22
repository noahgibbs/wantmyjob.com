require 'spec_helper'

describe Question do

  context "with a single question" do
    let(:question) do
      q = Question.new(:text => "At <company>, who's your daddy?",
                       :verified => true, :completed => true)
      q.question_answers << QuestionAnswer.new(:text => "Me")
      q.question_answers << QuestionAnswer.new(:text => "You")
      q.question_answers << QuestionAnswer.new(:text => "Somebody Else")
      q
    end

    it "should substitute markup correctly" do
      question.text_for("Heterodynamics").should ==
        "At Heterodynamics, who's your daddy?"
    end
  end

end
