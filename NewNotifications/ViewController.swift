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
        
        // Add an attachment
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        // Only for extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are what I've always dreamed of!"
        
        notif.attachments = [attachment]
        
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

