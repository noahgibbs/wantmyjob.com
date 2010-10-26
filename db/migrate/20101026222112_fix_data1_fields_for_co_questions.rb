class FixData1FieldsForCoQuestions < ActiveRecord::Migration
  def self.up
    Answer.where(:answer_type => Answer::COMPANY_ANSWER).find_each do |a|
      a.data1 += 1
      a.save!
    end
  end

  def self.down
    Answer.where(:answer_type => Answer::COMPANY_ANSWER).find_each do |a|
      a.data1 -= 1
      a.save!
    end
  end
end
