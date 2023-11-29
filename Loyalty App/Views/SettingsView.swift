//
//  SettingsView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 28/11/2023.
//

//import UserNotifications
import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment (\.modelContext) var context
    @Query var notificCentre: [NotificationCentre]
    
    @State private var notificationsEnabled: Bool = true

    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(colors: [.backgroundColour], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                        .onTapGesture {
                            notificCentre[0].areNotificationsEnabled = notificationsEnabled
                        }
                        .padding()
                    
                    Spacer()
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .preferredColorScheme(.dark)
    }

}

#Preview {
    SettingsView()
}
