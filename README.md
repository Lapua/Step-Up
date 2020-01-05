# StepUp

## 大学アプリ

大学の講義情報取得や出席の処理をするアプリ。

APIをリクエストするにはトークンが必要なため、Safariでログインし、Actionボタンから共有してもらう。

![](https://user-images.githubusercontent.com/29626666/71784534-d5693d80-3037-11ea-9167-fa2731b53bdc.jpg)
![](https://user-images.githubusercontent.com/29626666/71784575-2c6f1280-3038-11ea-8bf0-fdc400380a72.jpg)
![](https://user-images.githubusercontent.com/29626666/71784578-355fe400-3038-11ea-8fe1-d723a35bcdf3.jpg)

## 使用した主な技術・UIKit

- UITableView(custom cellをxibから作成)

- Alamofire - APIと通信するためのもの

- Codable - JSON

- SFSafariViewController, UIActicity - Safariを起動し、共有ボタンの処理をする。

## まだやるべきこと

- test codeを書く

- 便利な機能追加

- WiFi接続時かどうかを判断して、トークンを別々にUserDefaultに記録
