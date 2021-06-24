class Task < ApplicationRecord
  before_validation :set_nameless_name

  validates :name, presence: true
  validates :name, length: {maximum: 30}
  validate  :validate_name_not_including_comma
  
  private
  #nameカラムに,を入れないバリデーション
  def validate_name_not_including_comma
    errors.add(:name, "カンマを含めることはできません") if name &. include?( ",")
    # &. nilでない場合にメソッドを呼び出す
  end

  #nameカラムに入力がない場合'名前なし'というデータを入れる
  def set_nameless_name
    self.name = "名前なし" if name.blank
  end

end
