class League < ActiveRecord::Base
  has_many :matches, :dependent => :destroy

  validates :name, :presence => true
  validates :code, :presence => true

end
