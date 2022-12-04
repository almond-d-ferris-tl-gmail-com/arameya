class Room < ApplicationRecord
  #room1:ad_mem_message多(n)の関係
  #ad_mem_messageから見てroomは1→「belongs_to :room」(属する)を記述する
  #roomから見てad_mem_messageは多(n)→「has_many :ad_mem_messages, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  #optional: true・・・nilを許可
  has_many :ad_mem_messages, dependent: :destroy
end
