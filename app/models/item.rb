class Item < ApplicationRecord
    # 商品画像を扱う
    has_one_attached :image
    
    #genre1:item多(n)の関係
    #itemから見てgenreは1→「belongs_to :genre」(属する)を記述する
    #genreから見てitemは多(n)→「has_many :items, dependent: :destroy」を記述する
    #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
    belongs_to :genre
    
    #item1:cart_item多(n)の関係
    #cart_itemから見てitemは1→「belongs_to :item」(属するの意味)を記述する
    #itemから見てcart_itemは多(n)→「has_many :cart_items, dependent: :destroy」を記述する
    #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
    has_many :cart_items, dependent: :destroy
    
    #item1:order_detail多(n)の関係
    #order_detailから見てitemは1→「belongs_to :item」(属する)を記述する
    #itemから見てorder_detailは多(n)→「has_many :order_details, dependent: :destroy」を記述する
    #has_many:・・・テーブル同士を関連付ける、dependent(依存): :destroy・・・親モデルの削除時に、紐づいている子モデルも一緒に削除される
    has_many :order_details, dependent: :destroy
    
    def tax_included_price#税込の計算　.to_i→整数に変換して小数点を切り捨てる
        (price * 1.1).to_i
    end
    
    
    def get_image
        unless image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        image.variant(resize_to_limit: [200, 100]).processed
    end
    
    
    def get_profile_image
        (profile_image.attached?) ? profile_image : 'no_image.jpg'
    end
    
    def self.search_for(content, method)
        if method == 'perfect'
            Item.where(name: content)
        elsif method == 'forward'
            Item.where('name LIKE ?', content + '%')
        elsif method == 'backward'
            Item.where('name LIKE ?', '%' + content)
        else
        Item.where('name LIKE ?', '%' + content + '%')
        end
    end
end
