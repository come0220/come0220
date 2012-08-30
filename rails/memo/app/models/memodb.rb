class Memodb < ActiveRecord::Base

  has_many :comments

  validates :name, :presence => true
  validates :url,  :presence => true
end
