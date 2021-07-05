class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: {maximum: 30}
  validate  :validate_name_not_including_comma
  
  belongs_to :user
  has_one_attached :image

  scope :recent, -> {order(created_at: :desc)}

  def self.ransack_atributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransack_associatinos(auth_object = nil)
    []
  end

  #CSVデータにどの属性をどの順番で出力するかを定義
  def self.csv_attributes
    ["name","description", "created_at","updated_at"]
  end

  def self.generate_csv
    #CSVデータの文字列を生成（生成した文字列がgenerate_csvクラスメソッドの戻り値になる
    CSV.generate(headers: true) do |csv|
      #CSVの１行目としてヘッダを出力する
      csv << csv_attributes
      #全タスクを取得し、１レコードごとにCSVの１行を出力する
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr)}
        #mapメソッドでcsv_attributes配列の最初の要素をブロック（{}内）のattr変数に代入
        #代入されたattr変数の値でtask.send(attr)でtaskに結びついたattr変数を取得
        #新たな配列をcsvに出力
      end
    end
  end
  
  private
  #nameカラムに,を入れないバリデーション
  def validate_name_not_including_comma
    errors.add(:name, "カンマを含めることはできません") if name &. include?( ",")
    # &. nilでない場合にメソッドを呼び出す
  end

end
