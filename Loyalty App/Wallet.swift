//
//  Wallet.swift
//  Loyalty App
//
//  Created by Vito Borghi on 23/08/2023.
//

import Foundation

final class Wallet: ObservableObject, Codable {
    
    let defaults = UserDefaults.standard
    
    enum CodingKeys: CodingKey {
    case storedCards, activeCard
    }
    let storageKey = "storedCards"
    let activeKey = "activeCard"
    
    @Published var storedCards = [StampCard]()
    
    @Published var activeCard = StampCard()
    
    var count = 1
    func createNewStampCard() {
        storedCards.append(activeCard)
        activeCard = StampCard()
        count += 1
    }
    
    func removeCompleteCard() -> Bool  {
        if fullCardsAmount() > 0 {
            storedCards.removeFirst()
            return true
        }
        else {
            return false
        }
    }
    
    func fullCardsAmount() -> Int {

        return storedCards.reduce(0) { partialResult, StampCard in
           
            if StampCard.isCardFull() {
                return partialResult + 1
            }
            return partialResult
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(storedCards) {
                defaults.set(encoded, forKey: storageKey)
            }
        
        if let encoded = try? JSONEncoder().encode(activeCard) {
                defaults.set(encoded, forKey: activeKey)
            }
    }
    
    init(){
        if let storageData = UserDefaults.standard.data(forKey: storageKey) {
            if let decoded = try? JSONDecoder().decode([StampCard].self, from: storageData) {
                storedCards = decoded
            }
            if let activeData = UserDefaults.standard.data(forKey: activeKey) {
                if let decoded = try? JSONDecoder().decode(StampCard.self, from: activeData) {
                    activeCard = decoded
                }
            }
            return
        }
        
        self.storedCards = [StampCard]()
        self.activeCard = StampCard()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        storedCards = try container.decode([StampCard].self, forKey: .storedCards)

        activeCard = try container.decode(StampCard.self, forKey: .activeCard)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(storedCards, forKey: .storedCards)
        try container.encode(activeCard, forKey: .activeCard)
    }
    
}
