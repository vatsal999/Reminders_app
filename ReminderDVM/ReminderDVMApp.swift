//
//  ReminderDVMApp.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 20/04/23.
//

import SwiftUI

@main
struct ReminderDVMApp: App {
    // to observe this object, we add this property wrapper
    @StateObject var reminderlistModel : ReminderListModel = ReminderListModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(reminderlistModel) // by this,all views have access to reminderlistModel. its in the "environment"
        }
    }
}
