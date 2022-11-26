class Review < ApplicationRecord
    validates :star, numericality: {
    less_than_or_equal_to: 5.0,
    greater_than_or_equal_to: 1.0
    }, presence: true

  #member1:review多(n)の関係
  #reviewから見てmemberは1→「belongs_to :member」(属する)を記述する
  #memberから見てreviewは多(n)→「has_many :reviews, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  belongs_to :member

  #item1:review多(n)の関係
  #reviewから見てitemは1→「belongs_to :item」(属する)を記述する
  #itemから見てreviewは多(n)→「has_many :reviews, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  belongs_to :item

end
