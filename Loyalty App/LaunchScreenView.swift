//
//  LaunchScreenView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 04/10/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                LinearGradient(colors: [.backgroundColour], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Image("Launcher Image")
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                    
                    ProgressView()
                        .tint(.white)
                        .padding()
                }
            }
            .navigationDestination(for: String.self) { view in
                if view == "MainMenuView" {
                    MainMenuView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            path.append("MainMenuView")
            }
        }
    }
}


#Preview {
    LaunchScreenView()
}
