class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #admin1:rooms多(n)の関係
  #roomsから見てadminは1→「belongs_to :admin」(属する)を記述する
  #adminから見てroomsは多(n)→「has_many :rooms, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、through・・・中間となるテーブル名(members→room_connects→rooms)
  has_many :rooms,  dependent: :destroy
  
  #admin1:ad_mem_messages多(n)の関係
  #ad_mem_messagesから見てadminは1→「belongs_to :admin」(属する)を記述する
  #adminから見てad_mem_messagesは多(n)→「has_many :ad_mem_messages, dependent: :destroy」を記述する
  has_many :ad_mem_messages, dependent: :destroy
end
