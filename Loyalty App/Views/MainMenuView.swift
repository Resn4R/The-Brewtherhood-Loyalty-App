//
//  MainMenu.swift
//  Loyalty App
//
//  Created by Vito Borghi on 19/08/2023.
//

import SwiftUI
import SwiftData

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

func coffeeTicket(single singleFreeCoffee: Bool) -> Image {
    singleFreeCoffee ? Image("Coffee Ticket Single") : Image("Coffee Ticket Multi")
}


struct MainMenuView: View {
    @Query(animation: .smooth) var wallet: [StampCard]
    
    @State private var showInfoAlert = false
    @State private var showWalletViewSheet = false
    @State private var showMapViewSheet = false
    @State private var showStampDetails = false
    
    @State private var activeCardStampCount: (([StampCard]) -> Int) = { wallet in
        if let count = wallet.last?.stamps.count { return count }
        return -1
    }
    @State private var storedCardsCount: (([StampCard]) -> Int) = { wallet in
        wallet.count
    }
    @State private var fullCardsCount: (([StampCard]) -> Int) = { storedCards in
        return storedCards.reduce(0) { partialResult, StampCard in
            if StampCard.isCardFull() {
                return partialResult + 1
            }
            return partialResult
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.backgroundColour], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Text("") //IT FIXES THE ALIGNMENTS - DO NOT REMOVE
                        .padding()
                    
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
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .offset(y: -10)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 15)
                        VStack{
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 20) {
                                ForEach(0..<6) { index in
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 2)
                                            .frame(width: 75, height: 75, alignment: .center)
                                            .foregroundStyle(.backgroundColour)
                                        
                                        if activeCardStampCount(wallet) > index {
                                            Button {
                                                showStampDetails.toggle()
                                            } label: {
                                                stampIcon()
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 10)
                            
                            Text("Get \(6 - activeCardStampCount(wallet)) coffees to earn a free drink!")
                                .offset(y:10)
                                .foregroundStyle(.backgroundColour)
                            
                            ZStack{
                                Group {
                                    coffeeTicket(single: storedCardsCount(wallet) > 1 ? false : true)
                                        .resizable()
                                        .frame(width:370, height: 200)
                                        .offset(x:1.75, y: -20)
                                        .clipped()
                                        
                                    Text("\(storedCardsCount(wallet))")
                                        .foregroundStyle(.backgroundColour)
                                        .fontWeight(.heavy)
                                        .fontDesign(.serif)
                                        .font(.system(size: 20))
                                        .offset(x: -60, y: -13)
                                }
                                .opacity((fullCardsCount(wallet)) > 0 ? 1 : 0)
                            }
                            .offset(y: 50)
                        }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                            .frame(width: 400, height: 100)
                        HStack {
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.backgroundColour)
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
                                    .foregroundColor(.backgroundColour)
                                    .frame(width: 60, height: 60)
                                NavigationLink(destination: CameraView(), label: {
                                    Image(systemName: "camera")
                                        .foregroundStyle(.white)
                                        .font(.title)
                                })
                            }
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.backgroundColour)
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

#Preview {
    MainMenuView()
}
