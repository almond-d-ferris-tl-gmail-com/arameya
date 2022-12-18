Rails.application.routes.draw do

    # 会員用
    # URL /members/sign_in ...
    devise_for :members, skip: [:passwords], controllers: {
        registrations: "public/registrations",
        sessions: 'public/sessions'
    }
    
    # 管理者用
    # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords], controllers: {
        sessions: "admin/sessions"
    }
    
    # 会員
    scope module: :public do
        #namespace→scope moduleに変更
        #URLは変えず、ファイル構成だけ指定のパスにする(フォルダ名にはpublicをつけて、URLにはつけない)
        resources :rooms, only: [:create, :show] # 会員は1つのルームだけあればいいので、indexは不要
        resources :ad_mem_messages, only: [:create]
        get '/search', to: 'searches#search'
        # orders#showよりも上に記述しないとcompleteがid扱いされる
        post 'buy_orders/comfirm'
        get 'buy_orders/complete'
        resources :buy_orders, only: [:new, :index, :show, :create]
        
        # 注文完了時、カート内商品を全て削除する必要があるためdestroy_allを追加
        delete 'cart_items/destroy_all'
        resources :cart_items, only: [:index, :create, :update, :destroy]
        resources :buy_items, only: [:index, :show] do
            resources :reviews, only: [:index, :new, :show, :edit, :create, :update, :destroy]
        end
        resources :buy_addresses, only: [:index, :edit, :create, :update, :destroy]
        
        # membersはURLを変更するのでresourcesは使えない
        # show 会員のマイページ
        get 'members/my_page', to: 'members#show'
        # edit 会員の登録情報編集
        get 'members/information/edit', to: 'members#edit'
        # 会員の退会確認(URL変更なし)
        get 'members/unsubscribe'
        # 会員の退会完了(URL変更なし)
        get 'members/complete'
        # update 会員の登録情報更新
        patch '/members/information', to: 'members#update'
        # 会員の退会処理(ステータスの更新)(URL変更なし)
        patch '/members/withdraw'
        resources :members do
            resources :sell_order_details, only: [:update]
            resources :sell_orders, only: [:index, :show, :update]
            resources :sell_items, only: [:index, :new, :show, :edit, :create, :update, :destroy]
        end
        
        # 'URL' => 'コントローラ#アクション', as: :Prefix(パスが入った変数)の変更
        get '/' => 'homes#top', as: :root
        get '/about' => 'homes#about'
    end

    # 管理者
    namespace :admin do
        resources :genres, only: [:index, :edit, :create, :update, :destroy]
        # 「会員個人が行なったレビュー・評価」を表示するためにmembersの中にreviewsを入れる(do-endで括る)
        # フォルダ構成はそのままだが、URLとprefixが変わる
        resources :members, only: [:show, :edit, :update] do
            resources :rooms, only: [:create, :show] # 管理者は複数の会員とメッセージのやりとりがあるので複数のルームが必要→indexの一覧が必要→先にshowだけ作成する
            resources :ad_mem_messages, only: [:create]
            resources :reviews, only: [:index, :show, :destroy]
            resources :member_sells, only: [:index, :show]
            resources :member_buys, only: [:index, :show]
        end
        get '/' => 'homes#top'
    end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
# resourcesメソッド:railsで定義されている7つのアクションのルーティングを自動で作成する
#resourcesは[:new, :index, :show, :edit, :create, :update, :destroy]の7つのみ使えるので、その他は手動で追加する