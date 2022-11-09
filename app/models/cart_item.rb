class CartItem < ApplicationRecord
    def subtotal_price#小計の計算　.to_i→整数に変換して小数点を切り捨てる
        (item.tax_included_price * amount).to_i
    end
    
    #customer1:cart_item多(n)の関係
    #cart_itemから見てcustomerは1→「belongs_to :customer」(属する)を記述する
    #customerから見てcart_itemは多(n)→「has_many :cart_items, dependent: :destroy」を記述する
    #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
    belongs_to :customer
    
    #item1:cart_item多(n)の関係
    #cart_itemから見てitemは1→「belongs_to :item」(属する)を記述する
    #itemから見てcart_itemは多(n)→「has_many :cart_items, dependent: :destroy」を記述する
    #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
    belongs_to :item
    
end
