//
//  RedeemStampCard.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import SwiftUI
import SwiftData

struct RedeemCardView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismissView
    @Query var wallet: [StampCard]
    
    func redeemFreeCoffee() {
        context.delete(wallet[0])
        try? context.save()
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(colors: [.backgroundColour], startPoint: .top, endPoint: .bottom)
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

#Preview {
    RedeemCardView()
}
