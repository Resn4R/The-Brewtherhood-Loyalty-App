//
//  WalletView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 24/08/2023.
//

import SwiftUI

struct WalletView: View {
    @Environment(\.dismiss) var dismissView
    
    @ObservedObject var wallet: Wallet
    
    var body: some View {
        NavigationView{
            Text("""
                NUMBER OF STAMPCARDS
                \(wallet.wallet.count)
            
                NUMBER OF FULLY STAMPED CARDS
                \(wallet.fullCardsAmount())
            
                NUMBER OF STAMPS IN ACTIVE CARD
                \(wallet.activeCard.stampCard.count)
            
            """)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismissView()
                    }
                }
            }
        }
        .onAppear(){
            //addStamp(stampcard: wallet.activeCard())
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(wallet: Wallet())
    }
}
