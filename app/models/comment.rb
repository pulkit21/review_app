class Comment < ActiveRecord::Base
  belongs_to :merchant
  validates :rating, :review, :site, :user_name, presence: true
end
