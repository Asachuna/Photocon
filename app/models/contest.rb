class Contest < ApplicationRecord
  
  #コンテストの最大日数
  #開催中にも関わらず埋もれるコンテストを減らすのが目的。機能追加次第で延長を検討
  MAX_CONTEST_DAYS = 30
  
  belongs_to :user
  
  #コンテスト名は長すぎず
  validates :name, presence: true, length: { maximum: 25 }
  #説明は一応必須にしとく
  validates :description, presence: true, length: { maximum: 255 }
  
  #期日は1日以上最大日数以下
  validates :closing_day, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: MAX_CONTEST_DAYS}
  
end
