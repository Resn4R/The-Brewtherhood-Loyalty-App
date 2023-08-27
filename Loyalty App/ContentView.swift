//
//  ContentView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 19/08/2023.
//

import SwiftUI

//custom button WIP
struct StampButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .padding()
                .tint(.white)
        }
    }
}

struct stampIcon: View {
    var isShowing = false
    var body: some View {
        Image("stamp icon")
            .resizable()
            .scaledToFit()
            .rotationEffect(Angle.radians(Double.random(in: 180...275)))
            .offset(x:CGFloat.random(in: -30...30), y: CGFloat.random(in: -30...30))
    }
}


struct ContentView: View {
    @StateObject var wallet = Wallet()
    @State private var showInfoAlert = false
    @State private var showWalletViewSheet = false
    @State private var activeCardStampCount = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color(red: 50/255, green: 50/255, blue: 50/255)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Text("") //IT FIXES THE ALIGNMENTS - DO NOT REMOVE
                        .padding()
                    
                    //logo
                    HStack {
                        Image("Coffee shops logos Background Removed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200 , height: 200)
                        
                        Spacer()
                        
                        VStack{
                            Text ("The Brewtherood")
                                .font(.headline)
                                .fontDesign(.serif)
                            Text("COFFEE SOCIETY")
                                .font(.subheadline)
                                .fontDesign(.rounded)
                            HStack(spacing: 30){
                                Button{
                                    //instagram link
                                }label: {
                                    Image(systemName: "camera.metering.center.weighted")
                                }
                                Button{
                                    //facebook link
                                }label: {
                                    Image(systemName: "f.square")
                                }
                                Button{
                                    //twitter link
                                }label: {
                                    Image(systemName: "bird")
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        .foregroundColor(.white)
                        .offset(x: -30)
                        .padding()
                    }
                    
                    //loyalty card body
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .offset(y: -20)
                            .padding(.vertical, 10)
                        VStack{
                            ForEach(0..<2){ column in
                                HStack(spacing: 20){
                                    ForEach(0..<3) { row in
                                        ZStack{
                                            Circle()
                                                .stroke(lineWidth: 2)
                                                .scale(x: 0.75, y: 0.75)
                                                .offset(x: CGFloat(column) ,y: CGFloat(row))
                                            //stamp icon
                                            if wallet.activeCard.stampCard.count > (row + column * 3) {
                                                stampIcon()
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
                            Text("Get \(6 - activeCardStampCount) coffees to earn a free drink!")
                                .shadow(radius: 0)
                                .offset(y:-10)
                            
                            //free coffee image
                            ZStack{
                                Group {
                                    Circle()
                                        .stroke(lineWidth: 3)
                                        .scale(x: 0.75, y: 0.75)
                                        .offset(x: 3, y: -30)
                                    RoundedRectangle(cornerRadius: 20)
                                        .size(width: 185, height: 60)
                                        .offset(x: 102, y:17)
                                    Text("""
                                         \(wallet.fullCardsAmount())
                                         Free Coffee Tickets
                                         """)
                                        .fontDesign(.serif)
                                        .bold()
                                        .foregroundColor(.white)
                                        .offset(y: -30)
                                        .multilineTextAlignment(.center)
                                }
                                .opacity(wallet.fullCardsAmount() > 0 ? 1 : 0)
                            }
                        }
                        .shadow(radius: 1)
                        
                    }
                        
                    NavigationLink(destination: MockCameraView(wallet: wallet), label: {
                        Text("Scan QR Code")
                            .bold()
                            .fontDesign(.rounded)
                            .foregroundColor(.red)
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                }
                .toolbar {
                    ToolbarItem (placement: .navigationBarTrailing){
                        Button{
                            showInfoAlert = true
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundColor(.white)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        Button {
                            showWalletViewSheet.toggle()
                        } label: {
                            Image(systemName: "menucard")
                                .foregroundColor(.white)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                
                .onAppear(){
                    activeCardStampCount = wallet.activeCard.stampCard.count
                    if wallet.wallet.isEmpty {
                        print("wallet empty, creating new stampcard")
                        wallet.createNewStampCard()
                        print("new stampcard created ")
                    }
                    else {
                        print("""
                            Wallet not empty, no new stampcard created
                            \(wallet.wallet.count) stampcard present
                            \(wallet.activeCard.stampCard.count)
                            """)
                    }
                }
                
                .sheet(isPresented: $showWalletViewSheet) {
                    WalletView(wallet: wallet)
                }
                
                .alert("Info", isPresented: $showInfoAlert) {
                    Button("OK"){}
                } message: {
                    Text("The promotion applies to all handcrafted coffee, hot or iced, of any size.")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
