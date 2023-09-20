//
//  StampCard.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//
//  Save file for stamps 

import Foundation

class StampCard: Sequence, IteratorProtocol, Codable {
    var count: Int = 0
    
    var stamps = [Stamp]()
    
    init(stampCard: [Stamp] = [Stamp]()) {
        self.stamps = stampCard
        print("stampCard init completed successfully")
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
