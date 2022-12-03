class AdMemMessage < ApplicationRecord
  #admin1:ad_mem_message多(n)の関係
  #ad_mem_messageから見てadminは1→「belongs_to :admin」(属する)を記述する
  #adminから見てad_mem_messageは多(n)→「has_many :ad_mem_messages, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  #optional: true・・・nilを許可
  belongs_to :admin, optional: true
  
  #member1:ad_mem_message多(n)の関係
  #ad_mem_messageから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てad_mem_messageは多(n)→「has_many :ad_mem_messages, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  #optional: true・・・nilを許可
  belongs_to :member, optional: true
  
  # 0: 選択して下さい, 1: 購入に関する問い合わせ, 2: 販売に関する問い合わせ, 3: 取引に関する問い合わせ, 4:その他}
  enum am_message_title: { option: 0, buy: 1, sell: 2, deal: 3, others: 4 }
end
