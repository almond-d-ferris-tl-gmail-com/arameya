class Order < ApplicationRecord
  #customer1:order多(n)の関係
  #orderから見てcustomerは1→「belongs_to :customer」(属する)を記述する
  #customerから見てorderは多(n)→「has_many :orders, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  belongs_to :customer
  
  #order1:order_detail多(n)の関係
  #order_detailから見てorderは1→「belongs_to :order」(属する)を記述する
  #orderから見てorder_detailは多(n)→「has_many :order_details, dependent: :destroy」を記述する
  #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
  has_many :order_details, dependent: :destroy

  #payment_method(支払い方法)カラム
  #/nagano_cake/config/locales/ja.yml
  #クレジットカード: 0、銀行振込: 1
  enum payment_method: { credit_card: 0, transfer: 1 }

  #/nagano_cake/config/locales/ja.yml
  #受注ステータス(入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4)
  enum status: { waiting: 0, confirming: 1, making: 2, preparing: 3, sent: 4}
  
  def subtotal_price#小計の計算　.to_i→整数に変換して小数点を切り捨てる
      (item.tax_included_price * amount).to_i
  end
end
