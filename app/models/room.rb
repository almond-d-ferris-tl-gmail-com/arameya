class Room < ApplicationRecord
  #member1:rooms多(n)の関係
  #roomsから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てroomsは多(n)→「has_many :rooms」を記述する
  belongs_to :member

  #admin1:rooms多(n)の関係
  #roomsから見てadminは1→「belongs_to :admin」(属する)を記述する
  #adminから見てroomsは多(n)→「has_many :rooms, through: :room_connects」を記述する
  #has_many:・・・テーブル同士を関連付ける、through・・・中間となるテーブル名(members→room_connects→rooms)
  belongs_to :admin
  
  #room1:ad_mem_messages:多(n)の関係
  #ad_mem_messagesから見てroomは1→「belongs_to :room」(属する)を記述する
  #roomから見てad_mem_messagesは多(n)→「has_many :ad_mem_messages, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  has_many :ad_mem_messages, dependent: :destroy
end
