# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ログイン
Admin.find_or_create_by(
    email: "a@a",
    encrypted_password: "aaaaaa"
)

# 会員ログイン
Member.find_or_create_by(
    email: 'sakanagura@test.jp', encrypted_password: 'sakana', last_name: '肴倉', first_name: '康', last_name_kana: 'サカナグラ', first_name_kana: 'ヤスシ', company: '', department: '', postal_code: '522-0231', address: '滋賀県彦根市極楽寺町777', telephone_number: '070-4444-9999'
)    
Member.find_or_create_by(
    email: 'kirakira_neon@test.jp', encrypted_password: 'kirakira', last_name: '宮本', first_name: 'ねおん', last_name_kana: 'ミヤモト', first_name_kana: 'ネオン', company: '', department: '', postal_code: '108-0072', address: '東京都港区白金3-44-55　ルーチェ・カノッサ309号室', telephone_number: '090-1111-5555'
)

# ジャンル登録
Genre.find_or_create_by(
    name: '本'
)
Genre.find_or_create_by(
    name: 'CD・DVD'
)
Genre.find_or_create_by(
    name: 'ホーム＆キッチン' 
)

# 商品登録
Item.find_or_create_by(
    genre_id: Genre.find_by(name: 'ホーム＆キッチン').id, 
    member_id: Member.find_by(last_name: '肴倉', first_name: '康').id, 
    name: 'パナソニック ヘアドライヤー イオニティ シルバー調 EH-NE6E-S', 
    used_condition: false,
    introduction: '1.9m3/分※1の大風量で、パワフルドライ
                   温冷ツインフローで、毛流れの整ったツヤのある髪へ
                   速乾ノズルで毛束をほぐして、スピーディーに乾燥
                   本体質量:約530g
                   色:シルバー',
    price: 9000, postage: 0, sell_status: 0
    # image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sell_item1.jpg"), filename:"sell_item1.jpg") 
)
Item.find_or_create_by(
    genre_id: Genre.find_by(name: '本').id, 
    member_id: Member.find_by(last_name: '肴倉', first_name: '康').id, 
    name: '変な家 単行本（ソフトカバー） – 2021/7/22', 
    used_condition: false, 
    introduction: 'YouTubeでなんと1000万回以上再生!
                   あの「【不動産ミステリー】変な家」にはさらなる続きがあった!!
                   謎の空間、二重扉、窓のない子供部屋——間取りの謎をたどった先に見た、「事実」とは!?

                   知人が購入を検討している都内の中古一軒家。
                   開放的で明るい内装の、ごくありふれた物件に思えたが、間取り図に「謎の空間」が存在していた。
                   知り合いの設計士にその間取り図を見せると、この家は、そこかしこに「奇妙な違和感」が存在すると言う。
                   間取りの謎をたどった先に見たものとは……。

                   不可解な間取りの真相は!?突如消えた「元住人」は一体何者!?
                   本書で全ての謎が解き明かされる!

                   <目次>
                   第一章 変な家
                   第二章 いびつな間取り図
                   第三章 記憶の中の間取り
                   第四章 縛られた家', 
    price: 1250, postage: 0, sell_status: 0 
    # image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sell_item2.jpg"), filename:"sell_item2.jpg")
)
