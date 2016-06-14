class User < ApplicationRecord
  attr_accessible :email, :password, :temp_password
  has_many :posts

  enum role: [:admin, :user, :guest]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

end
