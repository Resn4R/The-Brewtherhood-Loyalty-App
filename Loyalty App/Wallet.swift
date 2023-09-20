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
        print("Wallet.createNewStampCarto d: new stamp card created")
    }
    
    func removeCompleteCard() -> Bool  { // Returns true if the redeem is successful, false if it isn't
        if fullCardsAmount() > 0 {
            storedCards.removeFirst()
            print("Wallet.removeCompleteCard: Complete card redeemed successfully")
            return true
        }
        else {
            print("Wallet.removeCompleteCard: Complete card redeem failed")
            return false
        }
    }
    
    func fullCardsAmount() -> Int {

        print("wallet.fullCardsAmount starting. Wallet: \(storedCards)")
        return storedCards.reduce(0) { partialResult, StampCard in
            print("""
                    \(partialResult)
                    \(StampCard.count)
                    \(StampCard.isCardFull())
            """)
            if StampCard.isCardFull() {
                print("if statement accessed. is card full? \(StampCard.isCardFull())")
                return partialResult + 1
            }
            print("past the if-block. partial result is \(partialResult)")
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
        //  load wallet, if existing
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
        print("Wallet.init: container \(container) created")

        storedCards = try container.decode([StampCard].self, forKey: .storedCards)
        print("Wallet.init: wallet \(storedCards) decoded")

        activeCard = try container.decode(StampCard.self, forKey: .activeCard)
        print("Wallet.init: activeCard \(activeCard) decoded")
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(storedCards, forKey: .storedCards)
        try container.encode(activeCard, forKey: .activeCard)
    }
    
}
