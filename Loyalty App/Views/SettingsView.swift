//
//  SettingsView.swift
//  Loyalty App
//
//  Created by Vito Borghi on 28/11/2023.
//

import UserNotifications
import SwiftUI

struct SettingsView: View {
    @StateObject private var notificationCentre = NotificationCentre()
    
    var body: some View {
        NavigationStack{
           
            Toggle("Enable Notifications", systemImage: "", isOn: $notificationCentre.areNotificationsEnabled)
                .onTapGesture { NotificationCentre.requestNotificationAccess() }
                .padding()
            
            Spacer()
            
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
    

}



#Preview {
    SettingsView()
}
