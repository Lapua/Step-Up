//
//  Network.swift
//  StepUp
//
//  Created by CrystalArrow on 2020/01/02.
//  Copyright © 2020 CrystalArrow. All rights reserved.
//

import Foundation
import Alamofire

class CSCNetwork {
    
    static var authTkt: String?
    private static let INFO_URL: String = "https://service.cloud.teu.ac.jp/eye/request/myinfo"
//    private static let INFO_URL: String = "http://safe-shelf-38481.herokuapp.com/api" // デモ用
    private static let ATTEND_URL: String = "https://service.cloud.teu.ac.jp/eye/m/"
    
    
    class private func setCookie(_ auth: String) {
        let cookie = HTTPCookie(properties: [
            .domain: "service.cloud.teu.ac.jp",
            .path: "/eye/request/myinfo",
            .name: "auth_tkt",
            .value: auth,
            .secure: "FALSE",
            .expires: NSDate(timeIntervalSinceNow: 60 * 60 * 24)
        ])!
        Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookie(cookie)
    }
    
    class func getMyInfo(_ viewController: FirstViewController) {
        if let authTkt = authTkt {
            setCookie(authTkt)
        } else {
            viewController.setTableMessage("Loginしてください")
            return
        }
        Alamofire.request(INFO_URL).response { response in
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
    
    class func attend(roomCode: String, seatCode: String) {
        if let authTkt = authTkt {
            setCookie(authTkt)
        } else {
            return
        }
        let url = ATTEND_URL + roomCode + "/" + seatCode
        Alamofire.request(url).response { response in
            if let error = response.error {
                print("Error :", error)
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
