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
    
    var backgroundColour = Color(red: 50/255, green: 50/255, blue: 50/255)

    
    func redeemFreeCoffee() {
        _ = wallet.removeCompleteCard()
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(colors: [backgroundColour], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack{
                    Spacer()
                    Text("Free drink redeemed successfully!")
                        .foregroundColor(.white)
                        .font(.title)
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
                .onAppear {
                    redeemFreeCoffee()
                }
            }
        }
    }
}

struct RedeemStamp_Previews: PreviewProvider {
    static var previews: some View {
        RedeemCardView(wallet: Wallet())
    }
}
