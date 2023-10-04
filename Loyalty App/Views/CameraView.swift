//
//  CameraView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import SwiftUI
import SwiftData

struct CameraView: View {
    @Environment (\.dismiss) var dismissView
    
    @Query var wallet: [StampCard]
    
    @State private var showAddStampSheet = false
    @State private var showRedeemCoffeeSheet = false
    @State private var showErrorAlert = false
    
    private let addStampUUID = "21F51556-802B-4E30-B4FE-4D4B7C5067B9"
    private let redeemCoffeeUUID  = "3E4EBFCF-509B-4C1D-A2C8-E6CAEEBCF747"
        
    @State private var scannedCode: String?

    var body: some View {
        
        CodeScannerView(codeTypes: [.qr], scanMode: .continuous) { response in
                if case let .success(result) = response {
                    scannedCode = result.string
                    
                    if scannedCode == addStampUUID{
                        showAddStampSheet.toggle()
                    }
                    else if scannedCode == redeemCoffeeUUID {
                        if wallet.filter({ $0.isFull() }).count > 0 { 
                            showRedeemCoffeeSheet.toggle()
                        }
                        else { showErrorAlert.toggle() }
                    }
                }
            }
            .ignoresSafeArea()

        .sheet(isPresented: $showAddStampSheet) {
            AddStampView()
        }
        .sheet(isPresented: $showRedeemCoffeeSheet) {
            RedeemCardView()
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK"){}
        } message: {
            Text("You don't have any complete stamp card. Complete a stamp card to redeem a free coffee.")
        }
    }
}

#Preview {
    CameraView()
}
