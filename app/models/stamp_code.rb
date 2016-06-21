class StampCode < ActiveRecord::Base
  validates :code, presence: true 
 # popyを含むのかチェック
#   validates :code, inclusion: { in: %w(popy_) }  
  
  belongs_to :user
  has_many :stamp
end
