//
//  MainMenu.swift
//  Loyalty App
//
//  Created by Vito Borghi on 19/08/2023.
//

import SwiftUI

struct stampIcon: View {
    var isShowing = false
    var body: some View {
        Image("stamp icon")
            .resizable()
            .scaledToFit()
            .rotationEffect(Angle.radians(Double.random(in: 0...359)))
            .offset(x:CGFloat.random(in: -20...20), y: CGFloat.random(in: -20...20))
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
                        Image("brand logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 175 , height: 175)
                        
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
                            .offset(y: -10)
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
                                                .foregroundStyle(backgroundColour)
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
                                .foregroundStyle(backgroundColour)
                            
                            //free coffee image
                            ZStack{
                                Group {
                                    Circle()
                                        .stroke(lineWidth: 3)
                                        .scale(x: 0.75, y: 0.75)
                                        .offset(x: 3, y: -30)
                                        .foregroundStyle(backgroundColour)

                                    RoundedRectangle(cornerRadius: 20)
                                        .size(width: 185, height: 60)
                                        .offset(x: 107, y: 13)
                                        .foregroundStyle(backgroundColour)

                                    Text("""
                                         \(wallet.fullCardsAmount())
                                         Free Coffee Tickets
                                         """)
                                        .fontDesign(.serif)
                                        .bold()
                                        .foregroundStyle(.white)
                                        .offset(y: -30)
                                        .multilineTextAlignment(.center)
                                }
                                .opacity(wallet.fullCardsAmount() > 0 ? 1 : 0)
                            }
                        }
                        .shadow(radius: 1)
                        
                    }
                    
                    //TOOLBAR START
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                            .frame(width: 400, height: 100)
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
                        .offset(y: -10)
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
                    activeCardStampCount = wallet.activeCard.stamps.count
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
                .preferredColorScheme(.dark)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
