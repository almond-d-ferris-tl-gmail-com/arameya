class Genre < ApplicationRecord
    
    #検索機能
    def self.search_for(content, method)
        if method == 'perfect'
            Book.where(title: content)
        elsif method == 'forward'
            Book.where('title LIKE ?', content+'%')
        elsif method == 'backward'
            Book.where('title LIKE ?', '%'+content)
        else
            Book.where('title LIKE ?', '%'+content+'%')
        end
    end
  
end
