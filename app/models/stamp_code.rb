class StampCode < ActiveRecord::Base
  validates :code, presence: true, length: { maximum: 9 }
 # popyを含むのかチェック
  validates :code, inclusion: { in: %w(popy_) }  
  
  belongs_to :user
  has_many :stamp
end
