class Crash < ActiveRecord::Base
  belongs_to :app
  has_one :report, :dependent => :destroy
  has_many :comments, :dependent => :destroy
end
