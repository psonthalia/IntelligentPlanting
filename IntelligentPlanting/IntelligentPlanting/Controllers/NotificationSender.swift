//
//  NotificationSender.swift
//  IntelligentPlanting
//
//  Created by Paran Sonthalia on 3/25/18.
//  Copyright © 2018 Howard Wang. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationSender: UIViewController {
    override func viewDidLoad() {
        var dateComponents = DateComponents()
        dateComponents.hour = Int(12)
        dateComponents.minute = Int(30)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "Please take "
        content.sound = UNNotificationSound.default()
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
}
