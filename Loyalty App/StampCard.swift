//
//  StampCard.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//
//  Save file for stamps 

import Foundation

class StampCard: Sequence, IteratorProtocol {
    var count: Int = 0
    
    @Published var stampCard = [Stamp]()
//    {
//        didSet {
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(stampCard) {
//                UserDefaults.standard.set(encoded, forKey: "StampCard")
//            }
//        }
//    }
//
//    init() {
//        if let savedStamps = UserDefaults.standard.data(forKey: "StampCard") {
//            if let decodedStamps = try? JSONDecoder().decode([Stamp].self, from: savedStamps) {
//                stampCard = decodedStamps
//                return
//            }
//        }
//        stampCard = []
//    }
    
    init(stampCard: [Stamp] = [Stamp]()) {
        self.stampCard = stampCard
        print("stampCard init completed successfully")
    }
    
    func isCardFull() -> Bool {
        stampCard.count < 6 ? false : true
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
