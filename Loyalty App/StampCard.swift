//
//  StampCard.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//
//  Save file for stamps 

import Foundation

struct StampCard: Sequence, IteratorProtocol, Codable {
    var count: Int = 0
    
    var stampCard = [Stamp]()
    
    init(stampCard: [Stamp] = [Stamp]()) {
        self.stampCard = stampCard
        print("stampCard init completed successfully")
    }
    
    func isCardFull() -> Bool {
        stampCard.count < 6 ? false : true
    }
    
    mutating func next() -> Int? {
            if count == 0 {
                return nil
            } else {
                defer { count -= 1 }
                return count
            }
        }
    
}
