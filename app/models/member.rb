class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #customer1:cart_item多(n)の関係
  #cart_itemから見てcustomerは1→「belongs_to :customer」(属する)を記述する
  #customerから見てcart_itemは多(n)→「has_many :cart_items, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  has_many :cart_items, dependent: :destroy

  #customer1:order多(n)の関係
  #orderから見てcustomerは1→「belongs_to :customer」(属する)を記述する
  #customerから見てorderは多(n)→「has_many :orders, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  has_many :orders, dependent: :destroy

  #customer1:address多(n)の関係
  #addressから見てcustomerは1→「belongs_to :customer」(属する)を記述する
  #customerから見てaddressは多(n)→「has_many :addresses, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  has_many :addresses, dependent: :destroy
         
end
