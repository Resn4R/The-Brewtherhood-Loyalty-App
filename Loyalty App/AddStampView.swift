//
//  AddStampView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import SwiftUI

struct AddStampView: View {
    @Environment(\.dismiss) var dismissView
    
    @ObservedObject var wallet: Wallet
    
    private let backgroundColour = Color(red: 50/255, green: 50/255, blue: 50/255)
    
    func addStamp(stampcard: StampCard) {
        let newStamp = Stamp(timeAndDate: Date.now)
         
         if wallet.activeCard.stamps.count < 6 {
             wallet.activeCard.stamps.append(newStamp)
             print("AddStamp:\(newStamp) added to \(wallet.activeCard)")
         
             if wallet.activeCard.stamps.count == 6 {
                 print("AddStamp: \(wallet.activeCard) is full. Creating a new stampcard")
                 wallet.createNewStampCard()
             }
         }
        wallet.save()
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(colors: [backgroundColour], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack{
                    Spacer()
                    Text("Stamp Added!")
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
                
            }
            
            .onAppear(){
                addStamp(stampcard: wallet.activeCard)
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

struct AddStamp_Previews: PreviewProvider {
    static var previews: some View {
        AddStampView(wallet: Wallet())
    }
}
