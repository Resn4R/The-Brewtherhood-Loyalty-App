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
    
    private let backgroundColour = Color(red: 50/255, green: 50/255, blue: 50/255)
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(colors: [backgroundColour], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("""
                    NUMBER OF STAMPCARDS
                    \(wallet.count)
                
                
                    NUMBER OF FULLY STAMPED CARDS
                    \(wallet.fullCardsAmount())
                
                
                    NUMBER OF STAMPS IN ACTIVE CARD
                    \(wallet.activeCard.stamps.count)
                
                """)
                    .foregroundColor(.white)
                    .font(.body)
                    .fontDesign(.serif)
                    
                    Spacer()
                    Button {
                        dismissView()
                    } label: {
                        Text("OK")
                            .foregroundColor(.black)
                            .fontDesign(.serif)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismissView()
                        } label: {
                            Text("Done")
                                .foregroundColor(.white)
                        }
                    }
                }
                
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(wallet: Wallet())
    }
}
