class Merchant < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  validates :name, :presence => {:message => 'Name cannot be blank'}
end
