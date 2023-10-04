//
//  Stamp.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import Foundation
import SwiftData

@Model
final class Stamp {
    let timestamp: Date
    
    init() {
        self.timestamp = Date.now
    }
}
