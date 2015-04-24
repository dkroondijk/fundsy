class User < ActiveRecord::Base
  # uses gem 'bcrypt'
  has_secure_password

  has_many :campaigns, dependent: :nullify
  has_many :pledges, dependent: :nullify

  validates :email, presence: true, uniqueness: true, email: true
  validates :first_name, presence: true

  def full_name
    ("#{first_name} #{last_name}").strip
  end

end
