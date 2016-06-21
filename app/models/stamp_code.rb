class StampCode < ActiveRecord::Base
  validates :code, presence: true, length: { maximum: 10 }
  
  belongs_to :user
  has_many :stamp
end
