//
//  StampCard.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//
//  Save file for stamps 

import Foundation
import SwiftData

@Model
final class StampCard: Sequence, IteratorProtocol {
    var count: Int = 0
    
    @Relationship(deleteRule: .cascade) var stamps: [Stamp]
    
    init() {
        self.stamps = [Stamp]()
    }
    
    func isCardFull() -> Bool {
        stamps.count < 6 ? false : true
    }
    
    func next() -> Int? {
            if count == 0 {
                return nil
            } else {
                defer { count -= 1 }
                return count
            }
        }
}
