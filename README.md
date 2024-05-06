## サービス名
Youるトレ

## サービス概要
Youtubeからランダムで筋トレの動画を取得して表示するサービス。

## このサービスへの思い・作りたい理由
筋トレをしようと思いyoutubeで検索してカテゴリ内で一まとめにしていたが、数が増えてどれをしようか迷うことが多くなってきたので、筋トレしたい部位を検索したらランダムで選んで欲しいと思ったため。

## ユーザー層について
筋トレをしようと思うが、種類が多くてどれをすれば良いか分からない人。<br>
運動をしたい初心者向け。

## サービスの利用イメージ
鍛えたい部位で検索するとランダムで3件表示される。<br>
筋トレ動画をどれにするか迷わなくなる。<br>

## ユーザーの獲得について
SNSを活用した宣伝

## サービスの差別化ポイント・推しポイント
カレンダー機能をつけてどの動画をしたかタイトルが表示されるようにする。<br>
どこの部位を多く鍛えているのか分かるようにする（部位ごとにカウント_累計）。<br>

## 機能候補
### MVPリリース時
筋トレの部位検索機能：ユーザーが鍛えたい部位を１箇所検索する機能。<br>
ランダムに動画が3件表示される。（検索例：腕、胸部、背中、お腹、脚）。<br>
動画表示機能：youtubeから取得した動画を表示。<br>
ユーザー登録：メールアドレス、名前など登録。<br>

### 本リリース時
筋トレ部位の検索機能；部位を3箇所検索可能。それぞれ動画が１つずつランダムに表示される。<br>
カレンダー機能：どの動画をいつ視聴したのか分かる。<br>
記録機能：日付・体重・体脂肪・腹囲の記録。<br>
どの部位の運動を多くしているか表示する。<br>
Xへのシェア：どの動画をしたかシェアできる。<br>

## 機能の実装方針予定
YouTube Data API ：youtubeから筋トレ動画を検索する。<br>
キーワード：ユーザーが特定の言語やフレーズで部位を指定できるように、APIの検索クエリに組み込む形で実装する。<br>
google Calendar API: ユーザーがどの動画でトレーニングをしたのかを記録するカレンダー機能の実装。

