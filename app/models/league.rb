class League < ActiveRecord::Base
  has_many :matches

  validates :name, :presence => true
  validates :code, :presence => true

end
