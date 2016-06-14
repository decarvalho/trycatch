class Comment < ApplicationRecord
  attr_accessible :description
  belongs_to :post
  
end
