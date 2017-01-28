//
//  ViewController.swift
//  NewNotifications
//
//  Created by Joseph Kim on 1/28/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Request Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification granted")
            } else {
                print("\(error)")
            }
        }
    }
    
    @IBAction func notifyBtnTapped(sender: UIButton) {
        scheduleNotification(inSeconds: 5) { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Could not schedule notification")
            }
        }
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) ->()) {
        
        let notif = UNMutableNotificationContent()
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are what I've always dreamed of!"
        
        
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("\(error)")
                completion(false)
            } else {
                completion(true)
            }
        
        }
    }
}

