//
//  Reminders.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 20/04/23.
//

import Foundation
import SwiftUI

struct Reminder : Identifiable {
    let id = UUID()
    let title : String
    let body : String
    let date : Date
    let status : Bool
}

struct ReminderList{
    static var list = [
        Reminder(title: "Buy Tickets", body: "buy them early!", date: Date(timeIntervalSinceNow: 15), status: true),
        Reminder(title: "Buy Tickets", body: "buy them early!", date: Date(timeIntervalSinceNow: 15), status: true),
        Reminder(title: "Buy Tickets", body: "buy them early!", date: Date(timeIntervalSinceNow: 15), status: true),
        Reminder(title: "Buy Tickets", body: "buy them early!", date: Date(timeIntervalSinceNow: 15), status: true),
    ]
}
