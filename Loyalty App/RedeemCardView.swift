//
//  RedeemStampCard.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import SwiftUI

struct RedeemCardView: View {
    @Environment(\.dismiss) var dismissView
    
    @ObservedObject var wallet: Wallet
    
    func redeemFreeCoffee() {
        let redeem = wallet.removeCompleteCard()
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
                .onAppear {
                    redeemFreeCoffee()
                }
        }
    }
}

struct RedeemStamp_Previews: PreviewProvider {
    static var previews: some View {
        RedeemCardView(wallet: Wallet())
    }
}
