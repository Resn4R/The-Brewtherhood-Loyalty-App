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
    
    func addStamp(stampcard: StampCard) {
        let newStamp = Stamp(timeAndDate: Date.now)
         
         if wallet.activeCard.stampCard.count < 6 {
             wallet.activeCard.stampCard.append(newStamp)
             print("AddStamp:\(newStamp) added to \(wallet.activeCard)")
         
             if wallet.activeCard.stampCard.count == 6 {
                 print("AddStamp: \(wallet.activeCard) is full. Creating a new stampcard")
                 wallet.createNewStampCard()
             }
         }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Text("STAMP ADDED")
                    .padding()
                Button("OK") { dismissView() }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
            }
        }
        .onAppear(){
            addStamp(stampcard: wallet.activeCard)
        }
    }
}

struct AddStamp_Previews: PreviewProvider {
    static var previews: some View {
        AddStampView(wallet: Wallet())
    }
}
