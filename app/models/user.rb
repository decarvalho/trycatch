class User < ApplicationRecord
  has_many :posts

  enum role: [:admin, :user, :guest]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def admin?
    self.role == :admin.to_s
  end

  accepts_nested_attributes_for :posts
end
