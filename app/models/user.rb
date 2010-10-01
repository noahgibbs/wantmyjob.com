class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :login

  def self.find_for_authentication(conditions = {})
    # Find the user object for the specified parameters
    profile = Profile.where("email = ?", conditions[:email])
    User.where("profile_id = ?", profile.id)
  end
end
