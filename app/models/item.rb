class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :product_rating
  has_many :comments, through: :product_rating
  validates :name, :presence => {:message => 'Name cannot be blank'}
end
