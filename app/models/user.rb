class User < ApplicationRecord
  has_secure_password
  #password属性(入力した生のパスワード)とpassword_confirmation属性(確認用)が追加される

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
end
