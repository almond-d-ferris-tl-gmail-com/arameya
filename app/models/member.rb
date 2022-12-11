class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #member1:review多(n)の関係
  #reviewから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てreviewは多(n)→「has_many :reviews, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  has_many :reviews, dependent: :destroy
  
  #member1:item多(n)の関係
  #itemから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てitemは多(n)→「has_many :items, dependent: :destroy」を記述する
  has_many :items, dependent: :destroy
  
  #member1:cart_item多(n)の関係
  #cart_itemから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てcart_itemは多(n)→「has_many :cart_items, dependent: :destroy」を記述する
  has_many :cart_items, dependent: :destroy

  #member1:order多(n)の関係
  #orderから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てorderは多(n)→「has_many :orders, dependent: :destroy」を記述する
  has_many :orders, dependent: :destroy

  #member1:address多(n)の関係
  #addressから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てaddressは多(n)→「has_many :addresses, dependent: :destroy」を記述する
  has_many :addresses, dependent: :destroy

  #member1:rooms多(n)の関係
  #roomsから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てroomsは多(n)→「has_many :rooms」を記述する
  has_many :rooms

  #member1:ad_mem_messages多(n)の関係
  #ad_mem_messagesから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てad_mem_messagesは多(n)→「has_many :ad_mem_messages, dependent: :destroy」を記述する
  has_many :ad_mem_messages, dependent: :destroy
end
