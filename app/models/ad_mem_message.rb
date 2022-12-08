class AdMemMessage < ApplicationRecord
  #member1:ad_mem_messages多(n)の関係
  #ad_mem_messagesから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てad_mem_messagesは多(n)→「has_many :ad_mem_messages, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  belongs_to :member
  
  #admin1:ad_mem_messages多(n)の関係
  #ad_mem_messagesから見てadminは1→「belongs_to :admin」(属する)を記述する
  #adminから見てad_mem_messagesは多(n)→「has_many :ad_mem_messages, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  belongs_to :admin
  
  #room1:ad_mem_messages:多(n)の関係
  #ad_mem_messagesから見てroomは1→「belongs_to :room」(属する)を記述する
  #roomから見てad_mem_messagesは多(n)→「has_many :ad_mem_messages, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  belongs_to :room

  # 0: 選択して下さい, 1: 購入に関する問い合わせ, 2: 販売に関する問い合わせ, 3: 取引に関する問い合わせ, 4:その他}
  enum am_message_title: { option: 0, buy: 1, sell: 2, deal: 3, others: 4 }
end
