//
//  Stamp.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import Foundation

struct Stamp: Identifiable, Codable {
    var id = UUID()
//    {
//        didSet {
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(self) {
//                UserDefaults.standard.set(encoded, forKey: "Stamp")
//            }
//        }
//    }
//
//    init () {
//        if let savedStamp = UserDefaults.standard.data(forKey: "Stamp") {
//            if let decodedStamp = try? JSONDecoder().decode(Stamp.self, from: savedStamp) {
//                self = decodedStamp
//                return
//            }
//        }
//        timeAndDate = Date.now
//    }
    var timeAndDate: Date
}
