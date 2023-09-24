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

func coffeeTicket(quantity num: Int) -> Image {
    num > 1 ? Image("Coffee Ticket Multi") : Image("Coffee Ticket Single")
}

struct MainMenuView: View {
    @StateObject var wallet = Wallet()
    @State private var showInfoAlert = false
    @State private var showWalletViewSheet = false
    @State private var showMapViewSheet = false
    @State private var activeCardStampCount = 0
    
    @State private var showStampDetails = false
    
    let backgroundColour = Color(red: 50/255, green: 50/255, blue: 50/255)
    
    
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
                                //.shadow(radius: 0)
                                .offset(y:-10)
                                .foregroundStyle(backgroundColour)
                            
                            //free coffee image -- NEEDS FIXING
                            ZStack{
                                Group {
                                    coffeeTicket(quantity: wallet.fullCardsAmount())
                                        .resizable()
                                        .frame(width:370, height: 200)
                                        .offset(x:1.75, y: -20)
                                        .clipped()
                                        
                                    Text("\(wallet.fullCardsAmount())")
                                        .foregroundStyle(backgroundColour)
                                        .fontWeight(.heavy)
                                        .fontDesign(.serif)
                                        .font(.system(size: 20))
                                        .offset(x: -60, y: -13)

                                }
                                .opacity(wallet.fullCardsAmount() > 0 ? 1 : 1)
                            }
                        }
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
                                Button { showMapViewSheet.toggle() } label: {
                                    Image(systemName: "map")
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
                
                .sheet(isPresented: $showMapViewSheet) {
                    MapView()
                }
                
                .alert("Info", isPresented: $showInfoAlert) {
                    Button("OK"){}
                } message: {
                    Text("The promotion applies to all handcrafted coffee, hot or iced, of any size.")
                }
                .toolbarColorScheme(.dark, for: .tabBar)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
