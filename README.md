# StepUp

## 大学アプリ

大学の講義情報取得や出席の処理をするアプリ。

APIをリクエストするにはトークンが必要なため、Safariでログインし、Actionボタンから共有してもらう。

## 使用した主な技術・UIKit

- UITableView(custom cellをxibから作成)

- Alamofire - APIと通信するためのもの

- Codable - JSON

- SFSafariViewController, UIActicity - Safariを起動し、共有ボタンの処理をする。

## まだやるべきこと

- test codeを書く

- 便利な機能追加

- WiFi接続時かどうかを判断して、トークンを別々にUserDefaultに記録
