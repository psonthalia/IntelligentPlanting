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
import Firebase

class NotificationSender: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference().child("SID").child("111111111111")
        
        DispatchQueue.global(qos: .background).async {
            ref.observe(DataEventType.value, with: { (snapshot) in
                if let postDict = snapshot.value as? [String] {
                    if(Int(postDict[postDict.count - 1])! > 280) {
                        let calendar = Calendar.current
                        let selectedDate = calendar.date(byAdding: .minute, value: 1, to: Date())
                        let delegate = UIApplication.shared.delegate as? AppDelegate
                        delegate?.scheduleNotification(at: selectedDate!)
                    }
                }
            })
        }

        
        
    }
}
