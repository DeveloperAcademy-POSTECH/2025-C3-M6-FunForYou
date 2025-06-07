//
//  DeviceActivityMonitorExtension.swift
//  FunForYouDeviceActivityMotinor
//
//  Created by 한건희 on 6/7/25.
//

import DeviceActivity
import UserNotifications

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        scheduleNotification(with: "intervalDidStart")
        // Handle the start of the interval.
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        scheduleNotification(with: "intervalDidEnd")
        // Handle the end of the interval.
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        scheduleNotification(with: "eventDidReachThreshold: \(activity)")
        
        // Handle the event reaching its threshold.
        
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        scheduleNotification(with: "intervalWillStartWarning")
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        scheduleNotification(with: "intervalWillEndWarning")
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        scheduleNotification(with: "eventWillReachThresholdWarning")
        // Handle the warning before the event reaches its threshold.
    }
    
    func scheduleNotification(with title: String) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = title // Using the custom title here
                content.body = "Here is the body text of the notification."
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // 5 seconds from now
                
                let request = UNNotificationRequest(identifier: "MyNotification", content: content, trigger: trigger)
                
                center.add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error)")
                    }
                }
            } else {
                print("Permission denied. \(error?.localizedDescription ?? "")")
            }
        }
    }
}
