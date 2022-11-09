class OrderDetail < ApplicationRecord
  #order1:order_details多(n)の関係
  #order_detailsから見てorderは1→「belongs_to :order」(属する)を記述する
  #orderから見てorder_detailsは多(n)→「has_many :order_details, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  belongs_to :order
    
  #item1:order_detail多(n)の関係
  #order_detailから見てitemは1→「belongs_to :item」(属する)を記述する
  #itemから見てorder_detailは多(n)→「has_many :order_details, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  belongs_to :item
  
  #/nagano_cake/config/locales/ja.yml
  #製作ステータス　製作不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3
  enum making_status: { ban_making: 0, waiting: 1, making: 2, made: 3}

    def subtotal_price#小計の計算　.to_i→整数に変換して小数点を切り捨てる
        (item.tax_included_price * amount).to_i
    end
end
