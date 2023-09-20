//
//  MockCameraView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import SwiftUI

struct CameraView: View {
    @Environment (\.dismiss) var dismissView
    @ObservedObject var wallet: Wallet
    
    @State private var showAddStampSheet = false
    @State private var showRedeemCoffeeSheet = false
    
    private let addStampUUID = "21F51556-802B-4E30-B4FE-4D4B7C5067B9"
    private let redeemCoffeeUUID  = "3E4EBFCF-509B-4C1D-A2C8-E6CAEEBCF747"
    
    @State var errorMessage = "You don't have any complete stamp card. Complete a stamp card to redeem a free coffee."
    @State var showErrorAlert = false
    @State var errorTitle = "Error"

    
    @State private var scannedCode: String?
    
    var body: some View {
        
            CodeScannerView(codeTypes: [.qr]) { response in
                if case let .success(result) = response {
                    scannedCode = result.string
                    
                    if scannedCode == addStampUUID{
                        showAddStampSheet.toggle()
                    }
                    else if scannedCode == redeemCoffeeUUID {
                        if wallet.fullCardsAmount() > 0 { showRedeemCoffeeSheet.toggle() }
                        else { showErrorAlert.toggle() }
                    }
                }
            }

        .sheet(isPresented: $showAddStampSheet) {
            AddStampView(wallet: wallet)
        }
        .sheet(isPresented: $showRedeemCoffeeSheet) {
            RedeemCardView(wallet: wallet)
        }
        .alert(errorTitle, isPresented: $showErrorAlert) {
            Button("OK"){}
        } message: {
            Text(errorMessage)
        }
    }
}

struct MockCameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(wallet: Wallet())
    }
}
