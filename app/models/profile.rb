class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :jobs

  def next_question
    
  end
end
