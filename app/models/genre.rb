class Genre < ApplicationRecord
    #itemのほうでgenre.nameを使用したい→itemを所有している(複数形にする)
    #genre1:item多(n)の関係
    #itemから見てgenreは1→「belongs_to :genre」(属する)を記述する
    #genreから見てitemは多(n)→「has_many :items, dependent: :destroy」を記述する
    #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
    has_many :items, dependent: :destroy
    
end
