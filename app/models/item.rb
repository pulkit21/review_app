class Item < ActiveRecord::Base
  belongs_to :merchant
  validates :name, :presence => {:message => 'Name cannot be blank'}
end
