//
//  MockCameraView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import SwiftUI

struct MockCameraView: View {
    @ObservedObject var wallet: Wallet
    
    @State private var showAddStampSheet = false
    @State private var showRedeemCoffeeSheet = false
    
    var body: some View {
            VStack{
                Spacer()
                
                Text("Mock QR CODE READER")
                    .padding()
                    .font(.title)
                Button("QR CODE ADD STAMP") {
                    showAddStampSheet.toggle()
                }
                .padding(.vertical, 100)
                Button("QR CODE REDEEM COFFEE") {
                    showRedeemCoffeeSheet.toggle()
                }
                Spacer()
            }
            .sheet(isPresented: $showAddStampSheet) {
                AddStamp(wallet: wallet)
            }
            .sheet(isPresented: $showRedeemCoffeeSheet) {
                RedeemStampCard(wallet: wallet)
            }
    }
}

struct MockCameraView_Previews: PreviewProvider {
    static var previews: some View {
        MockCameraView(wallet: Wallet())
    }
}
