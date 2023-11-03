class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  enum :role, [ :guest, :editor, :admin ]

  has_many :answers
  has_many :questions

  after_initialize do
    if self.new_record?
      self.role ||= :guest
    end
  end
end
