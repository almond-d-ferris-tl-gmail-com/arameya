class Item < ApplicationRecord
    # 商品画像を扱う
    has_one_attached :image
    
    def get_profile_image
        (profile_image.attached?) ? profile_image : 'no_image.jpg'
    end
    
    def self.search_for(content, method)
        if method == 'perfect'
            User.where(name: content)
        elsif method == 'forward'
            User.where('name LIKE ?', content + '%')
        elsif method == 'backward'
            User.where('name LIKE ?', '%' + content)
        else
            User.where('name LIKE ?', '%' + content + '%')
        end
    end
end
