//
//  RedeemStampCard.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import SwiftUI

struct RedeemStampCard: View {
    @Environment(\.dismiss) var dismissView
    
    @ObservedObject var wallet: Wallet
    
    enum error: Error {
        case noCompleteCardPresent, noActiveCard, activeCardAlreadyPresent
    }
    @State var errorMessage = "You don't have any complete stamp card. Complete a stamp card to redeem a free coffee."
    @State var showErrorAlert = false
    @State var errorTitle = "Error"
    
    func redeemFreeCoffee() {
        let redeem = wallet.removeCompleteCard()
        if  !redeem {
            showErrorAlert.toggle()
        }
    }
  
    
    var body: some View {
        NavigationView{
            Text("Redeem Coffee")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismissView()
                        }
                    }
                }
                .alert(errorTitle, isPresented: $showErrorAlert) {
                    Button("OK"){
                        dismissView()
                    }
                } message: {
                    Text(errorMessage)
                }
                .onAppear {
                    redeemFreeCoffee()
                }
        }
    }
}

struct RedeemStamp_Previews: PreviewProvider {
    static var previews: some View {
        RedeemStampCard(wallet: Wallet())
    }
}
