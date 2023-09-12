//
//  Wallet.swift
//  Loyalty App
//
//  Created by Vito Borghi on 23/08/2023.
//

import Foundation

class Wallet: ObservableObject {
    
    enum CodingKeys: CodingKey {
    case wallet, activeCard
    }
    
    var count: Int = 0
    @Published var wallet = [StampCard]()
    @Published var activeCard = StampCard()
    
    func createNewStampCard() {
        activeCard = StampCard()
        wallet.append(activeCard)
        print("Wallet.createNewStampCard: new stamp card created")
    }
    
    func removeCompleteCard() -> Bool  { // Returns true if the redeem is successful, false if it isn't
        if fullCardsAmount() > 0 {
            wallet.removeFirst()
            print("Wallet.removeCompleteCard: Complete card redeemed successfully")
            return true
        }
        else {
            print("Wallet.removeCompleteCard: Complete card redeem failed")
            return false
        }
    }
    
    func fullCardsAmount() -> Int {

        print("wallet.fullCardsAmount starting. Wallet: \(wallet)")
        return wallet.reduce(0) { partialResult, StampCard in
            print("""
                    \(partialResult)
                    \(StampCard.count)
            """)
            if StampCard.isCardFull() {
                print("if statement accessed. is card full? \(StampCard.isCardFull())")
                return partialResult + 1
            }
            print("past the if-block. partial result is \(partialResult)")
            return partialResult
        }
    }
        
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        print("Wallet.init: container \(container)")
//
//        wallet = try container.decode([StampCard].self, forKey: .wallet)
//        print("Wallet.init: wallet \(wallet)")
//
//        activeCard = try container.decode(StampCard.self, forKey: .activeCard)
//        print("Wallet.init: activeCard \(activeCard)")
//    }
    
    init(){}
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(wallet, forKey: .wallet)
//        try container.encode(activeCard, forKey: .activeCard)
//    }
    
}
