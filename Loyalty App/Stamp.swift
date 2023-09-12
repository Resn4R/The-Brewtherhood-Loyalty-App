//
//  Stamp.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import Foundation

struct Stamp: Identifiable, Codable {
    var id = UUID()
    var timeAndDate: Date
}
