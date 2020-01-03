//
//  Network.swift
//  StepUp
//
//  Created by CrystalArrow on 2020/01/02.
//  Copyright © 2020 CrystalArrow. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    
    static var authTkt: String?
    
    class func getMyInfo(_ viewController: FirstViewController) {
        guard let authTkt = authTkt else {
            viewController.setTableMessage("Loginしてください")
            return
        }
        let cookie = HTTPCookie(properties: [
            .domain: "service.cloud.teu.ac.jp",
            .path: "/eye/request/myinfo",
            .name: "auth_tkt",
            .value: authTkt,
            .secure: "FALSE",
            .expires: NSDate(timeIntervalSinceNow: 60 * 60 * 24)
        ])!
        Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookie(cookie)
        
//        Alamofire.request("https://service.cloud.teu.ac.jp/eye/request/myinfo").response { response in
        Alamofire.request("http://safe-shelf-38481.herokuapp.com/api").response { response in
            if let data = response.data {
                do {
                    let myInfo: MyInfo = try JSONDecoder().decode(MyInfo.self, from: data)
                    if myInfo.lectures.count == 0 {
                        viewController.setTableMessage("本日の講義はありません")
                    } else {
                        viewController.setTableRows(myInfo.lectures)
                    }
                } catch {
                    viewController.setTableMessage("ログインしてください")
                }
            } else {
                viewController.setTableMessage("エラー")
            }
        }
    }
    
}

struct Lectures: Codable {
    var lecture_name: String
    var url: String
    var room_name: String
}

struct MyInfo: Codable {
    var lectures: [Lectures]
}
