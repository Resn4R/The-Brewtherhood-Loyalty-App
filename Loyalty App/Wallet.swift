//
//  Wallet.swift
//  Loyalty App
//
//  Created by Vito Borghi on 23/08/2023.
//

import Foundation

class Wallet: ObservableObject, Sequence, IteratorProtocol {
    var count: Int = 0
   @Published var wallet = [StampCard]()
//  {
//        didSet {
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(wallet) {
//                UserDefaults.standard.set(encoded, forKey: "Wallet")
//            }
//        }
//    }
//
//    init(Wallet: [StampCard] = [StampCard]()) {
//        self.wallet = Wallet
////        createNewStampCard()
//
//        if let savedWallet = UserDefaults.standard.data(forKey: "Wallet") {
//            if let decodedWallet = try? JSONDecoder().decode([StampCard].self, from: savedWallet) {
//                wallet = decodedWallet
//                return
//            }
//        }
//        wallet = []
//        createNewStampCard()
//
//    }
    @Published var activeCard = StampCard()
    
    init() {
        self.wallet = []
        createNewStampCard()
        print("wallet.init completed successfully")
    }
    
    func createNewStampCard() {
        activeCard = StampCard()
        wallet.append(activeCard)
        print("Wallet.createNewStampCard: new stamp card created")
    }
    
    func removeCompleteCard() -> Bool  { // Returns true if the redeem is successful, false if it isn't
        if fullCardsAmount() > 0 {
            wallet.removeFirst()
            print("Wallet: Complete card redeemed successfully")
            return true
        }
        else {
            print("Complete card redeem failed")
            return false
        }
    }
    
    func fullCardsAmount() -> Int {
        var fullStampedCards = 0
        for card in wallet {
            card.isCardFull() ? fullStampedCards += 1 : nil
        }
        return fullStampedCards
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
