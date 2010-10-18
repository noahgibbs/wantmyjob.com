class User < ActiveRecord::Base
  has_one :profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation,
    :remember_me

  #validate :login, :uniqueness => true
  #validate :email, :uniqueness => true

  def self.find_for_database_authentication(conditions = {})
    # Find the user object for the specified parameters
    value = conditions[authentication_keys.first]
    where(["login = :value OR email = :value", { :value => value }]).first
  end

end
