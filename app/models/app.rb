class App < ActiveRecord::Base
  has_many :crashes, :dependent => :destroy
end
