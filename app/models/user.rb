class User < ApplicationRecord
  has_many :posts
  has_many :comments

  # The line below must be inside the class
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
end
