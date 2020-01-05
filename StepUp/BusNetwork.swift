//
//  BusNetwork.swift
//  StepUp
//
//  Created by CrystalArrow on 2020/01/06.
//  Copyright © 2020 CrystalArrow. All rights reserved.
//

import Foundation
import Alamofire

class BusNetwork {
    
    class func getTable(_ terminalID: Int) {
        let url = "https://bus.t-lab.cs.teu.ac.jp/api/v1/timetables?from=\(terminalID)&limit=20"
        Alamofire.request(url).response { response in
            if let error = response.error {
                print("Error :", error)
            } else {
                if let data = response.data {
                    parseResponse(data)
//                    do {
//                        let bus: Bus = try JSONDecoder().decode(Bus.self, from: data)
//                        print(bus)
//                    } catch {
//                        print("Error")
//                    }
                }
            }
        }
    }
    
    class private func parseResponse(_ data: Data) {
//        guard let responseString = String(data: data, encoding: .utf8) else {
//            return
//        }
//        var arr = responseString.components(separatedBy: "T")
//        if arr.count <= 2 {
//            return
//        }
//        arr.removeFirst()
//        arr.removeLast()
//        let baseDate = Calendar(identifier: .gregorian).startOfDay(for: Date())
//        var timeList: [Date] = []
//        for item in arr {
//            let str = item[..<item.index(item.startIndex, offsetBy: 5)]
//            let timeStr = str.components(separatedBy: ":")
//            let calender = Calendar(identifier: .gregorian)
//            let date = calender.date(bySettingHour: Int(times[0])!, minute: Int(times[1])!, second: 0, of: Date())
//            timeList.append(date)
//        }
//        print(timeList)
    }
    
}

struct Bus: Codable {
//    var timetables: Timetables
    var success: String
}

struct Timetables: Codable {
    var departure_time: String
}
