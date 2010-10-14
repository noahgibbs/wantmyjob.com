class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :jobs
  #has_many :answers

  def next_question
    
  end
end
