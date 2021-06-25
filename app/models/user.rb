class User < ApplicationRecord
  has_secure_password
  #password属性(入力した生のパスワード)とpassword_confirmation属性(確認用)が追加される

  has_many :tasks

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
end
