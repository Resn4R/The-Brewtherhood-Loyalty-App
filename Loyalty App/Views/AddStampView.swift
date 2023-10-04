//
//  AddStampView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 21/08/2023.
//

import SwiftUI
import SwiftData

struct AddStampView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismissView
    
    @Query var wallet: [StampCard]
    
    
    @State private var activeCardStampCount: ((StampCard?) -> Int) = { stampCard in
        if let stamps = stampCard?.stamps.count { return stamps }
        else { return -1 }
    }
    @State private var freeCoffee = false
    
    func addStamp() {
        let newStamp = Stamp()
         
         if let activeCard = wallet.last {
            if !(activeCard.isFull()) { activeCard.stamps.append(newStamp) }
             
             if activeCard.isFull() {
                 freeCoffee.toggle()
                 context.insert(activeCard)
            }
        }
        try? context.save()
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(colors: [.backgroundColour], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    Group{
                        Text("""
                            Stamp Added.
                            You now have \(activeCardStampCount(wallet.last)) stamps.
                            """)
                        
                        Text("""
                            Congratulations!
                            
                            You have collected enough stamps to redeem a free coffee!
                            """)
                            .foregroundStyle(.specialColour)
                            .opacity(freeCoffee ? 1 : 0)
                    }
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontDesign(.serif)
                    
                    Spacer()
                    Button {
                        freeCoffee ? context.insert(StampCard()) : nil
                        dismissView()
                    } label: {
                        Text("OK")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .fontDesign(.serif)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    Spacer()
                }
            }
            
            .onAppear(){
                addStamp()
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

#Preview {
    AddStampView()
}
