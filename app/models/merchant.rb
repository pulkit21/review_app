class Merchant < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  validates :name, :presence => {:message => 'Name cannot be blank'}
end
