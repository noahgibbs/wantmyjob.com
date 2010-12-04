class User < ActiveRecord::Base
  has_many :profiles

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation,
    :remember_me

  validate :login, :uniqueness => true
  #validate :email, :uniqueness => true

  def self.find_for_database_authentication(conditions = {})
    # Find the user object for the specified parameters
    value = conditions[authentication_keys.first]
    where(["login = :value OR email = :value", { :value => value }]).first
  end

  def current_profile
    p = profiles.where(:current => true)
    p && p.first
  end

  def profile
    current_profile
  end

  def set_current_profile(p)
    profiles.where(:current => true).each { |cp| cp.current = false; cp.save! }
    p.current = true
    p.save!
  end

end
