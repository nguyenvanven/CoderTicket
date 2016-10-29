class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence:true, uniqueness:{case_insensitive:true}
  validates :password, presence:true
end
