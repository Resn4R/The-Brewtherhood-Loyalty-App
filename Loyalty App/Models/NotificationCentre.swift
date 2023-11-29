//
//  NotificationCentre.swift
//  Loyalty App
//
//  Created by Vito Borghi on 28/11/2023.
//

import SwiftData
import Foundation
import UserNotifications

class NotificationCentre: ObservableObject {
    @Published var areNotificationsEnabled = false
    
    public static let shared = NotificationCentre()
    
    static func sendNotification() {
        
        guard shared.areNotificationsEnabled else {
            print("Error: Can't send notifications, permissions not enabled.")
            return
        }
        
        do {
            let container = try ModelContainer(for: StampCard.self)
            let context = ModelContext(container)
            let fetchDescriptor = FetchDescriptor<StampCard>()
            let wallet = try context.fetch(fetchDescriptor)
            
            guard wallet.count > 2 else {
                print("Error: Can't send notifications, no fully stamped cards available")
                return
            }
        } catch {
            print("error while creating model context: \(error.localizedDescription)")
        }
        
        let content = UNMutableNotificationContent()
        content.title = "He, you still got a free drink voucher!"
        content.subtitle = "Why don't you go to your friendly neighbourhood's coffee shop for a free treat? You deserve it."
        content.sound = UNNotificationSound.default
                                                                // one week in seconds
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 604_800, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    static func requestNotificationAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print ("all set")
                self.sendNotification()
            } else if let error = error {
                print(error.localizedDescription)
                shared.areNotificationsEnabled = false
            }
        }
    }
    
}
