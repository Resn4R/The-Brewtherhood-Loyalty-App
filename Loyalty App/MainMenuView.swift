//
//  MainMenu.swift
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
                .tint(.red)
            Rectangle()
                .tint(.white)
                .offset(y: -100)
                
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


struct MainMenuView: View {
    @StateObject var wallet = Wallet()
    @State private var showInfoAlert = false
    @State private var showWalletViewSheet = false
    @State private var activeCardStampCount = 0
    
    @State private var showStampDetails = false
    
    private let backgroundColour = Color(red: 50/255, green: 50/255, blue: 50/255)
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [backgroundColour], startPoint: .top, endPoint: .bottom)
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
                            Group {
                                Text ("The Brewtherood")
                                    .font(.title2)
                                    .fontDesign(.serif)
                                Text("COFFEE SOCIETY")
                                    .font(.subheadline)
                                    .fontDesign(.rounded)
                            }
                            .offset(y: 5)
                            
                            HStack(spacing: 30){
                                Link(destination: URL(string: "https://www.instagram.com")!) {
                                    Image(systemName: "camera.metering.center.weighted")
                                        .font(.title)
                                }
                                
                                Link(destination: URL(string: "https://www.facebook.com")!) {
                                    Image(systemName: "f.square")
                                        .font(.title)
                                }
                                
                                Link(destination: URL(string: "https://www.twitter.com")!) {
                                    Image(systemName: "bird")
                                        .font(.title)
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
                            .padding(.horizontal, 15)
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
                                            if activeCardStampCount > (row + column * 3){
                                                Button {
                                                    showStampDetails.toggle()
                                                } label: {
                                                    stampIcon()
                                                }
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
                                        .offset(x: 115, y:17)
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
                        //  SCAN QR BUTTON START
                    
//                    NavigationLink(destination: CameraView(wallet: wallet), label: {
//                        Text("Scan QR Code")
//                            .bold()
//                            .fontDesign(.rounded)
//                            .foregroundColor(.red)
//                    })
//                    .buttonStyle(.borderedProminent)
//                    .tint(.white)
                    //BUTTON END
                    
                    //TOOLBAR START
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                            .frame(width: 400, height: 90)
                        HStack {
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(backgroundColour)
                                    .frame(width: 60, height: 60)
                                    
                                Button{} label: {
                                    Image(systemName: "house")
                                        .foregroundStyle(.white)
                                        .font(.title)
                                }
                            }
                            .offset(x: -20)
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(backgroundColour)
                                    .frame(width: 60, height: 60)
                                NavigationLink(destination: CameraView(wallet: wallet), label: {
                                    Image(systemName: "camera")
                                        .foregroundStyle(.white)
                                        .font(.title)
                                })
                            }
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(backgroundColour)
                                    .frame(width: 60, height: 60)
                                Button { showWalletViewSheet.toggle() } label: {
                                    Image(systemName: "menucard")
                                        .foregroundColor(.white)
                                        .font(.title)
                                }
                            }
                            .offset(x: 20)
                            Spacer()
                        }
                    }
                    //TOOLBAR END
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
                }
                .ignoresSafeArea()
                
                .onAppear(){
                    
                    if wallet.wallet.isEmpty {
                        print("Main menu.onAppear: wallet empty, creating new stampcard")
                        wallet.createNewStampCard()
                        print("Main menu.onAppear: new stampcard created ")
                    }
                    else {
                        print("""
                            Main menu.onAppear: Wallet not empty, no new stampcard created
                            \(wallet.wallet.count) stampcard present
                            \(wallet.activeCard.stampCard.count) stamps in active card
                            """)
                    }
                    activeCardStampCount = wallet.activeCard.stampCard.count
                    print("Main menu.onAppear: activeCardStampCount: \(activeCardStampCount)")
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
        MainMenuView()
    }
}
