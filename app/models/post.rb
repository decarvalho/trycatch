class Post < ApplicationRecord
  attr_accessible :title, :description
  belongs_to :user
  has_many :comments

  accepts_nested_attributes_for :comments
end
