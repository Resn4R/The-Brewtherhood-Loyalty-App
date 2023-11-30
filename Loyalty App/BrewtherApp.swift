//
//  Loyalty_AppApp.swift
//  Loyalty App
//
//  Created by Vito Borghi on 19/08/2023.
//

import SwiftData
import SwiftUI


@main
struct BrewtherApp: App {
    @State var path = NavigationPath()
    
    
    @MainActor let appContainer: ModelContainer = {
        do {
            let container = try ModelContainer(for: StampCard.self, NotificationCentre.self)
            
            var stampCardFetchDescriptor = FetchDescriptor<StampCard>()
            stampCardFetchDescriptor.fetchLimit = 1
            
            guard try container.mainContext.fetch(stampCardFetchDescriptor).count == 0 else { return container }
            
            container.mainContext.insert(StampCard())
            
            return container
        } catch { fatalError("Failed to create container") }
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path){
                ZStack{
                    BackgroundColour()
                    LauncherImage()
                }
                .navigationDestination(for: String.self) { view in
                    view == "MainMenuView" ? MainMenuView() : nil
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    path.append("MainMenuView")
                }
            }
        }
        .modelContainer(appContainer)
        //.modelContainer(for: NotificationCentre.self)
        
    }
}

struct BackgroundColour: View {
    var body: some View {
        LinearGradient(colors: [.backgroundColour], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}
struct LauncherImage: View {
    var body: some View {
        Image("Launcher Image")
            .resizable()
            .scaledToFit()
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
    }
}
