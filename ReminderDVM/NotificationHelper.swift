//
//  NotificationHelper.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 28/04/23.
//

import Foundation
import UserNotifications

class NotificationHelper {
    func askPermission(){
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notification auth permitted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func addNotification(id: String, date: Date, title: String, body: String){
        var trigger : UNNotificationTrigger?
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        //let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let request = UNNotificationRequest(identifier: id , content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func deleteNotification(id: String){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
}
