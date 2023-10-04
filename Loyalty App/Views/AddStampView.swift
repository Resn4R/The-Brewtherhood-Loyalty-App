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
    
    @State private var showFreeCoffeeAlert = true
    @State private var activeCardStampCount: ((StampCard?) -> Int) = { stampCard in
        if let card = stampCard?.count { return card }
        else { return -1 }
    }
    
    func addStamp(stampcard: StampCard?) {
        let newStamp = Stamp()
         
         if let activeCard = wallet.last {
             if !activeCard.isCardFull(){ activeCard.stamps.append(newStamp) }
         
             if activeCard.isCardFull() {
                 showFreeCoffeeAlert.toggle()
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
                            .opacity(showFreeCoffeeAlert ? 1 : 0)
                    }
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontDesign(.serif)
                    
                    Spacer()
                    Button {
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
                addStamp(stampcard: wallet.last)
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
