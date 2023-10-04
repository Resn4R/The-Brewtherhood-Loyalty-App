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
    
    @MainActor
    let appContainer: ModelContainer = {
        do {
            let container = try ModelContainer(for: StampCard.self)
            
            var stampCardFetchDescriptor = FetchDescriptor<StampCard>()
            stampCardFetchDescriptor.fetchLimit = 1
            
            guard try container.mainContext.fetch(stampCardFetchDescriptor).count == 0 else { return container }
            
            container.mainContext.insert(StampCard())
            return container
        }   catch {
                fatalError("Failed to create container")
            }
    }()
    
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
        }
        .modelContainer(appContainer)
    }
}
