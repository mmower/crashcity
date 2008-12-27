class App < ActiveRecord::Base
  validates_uniqueness_of :bundle
  
  has_many :crashes, :dependent => :destroy
end
