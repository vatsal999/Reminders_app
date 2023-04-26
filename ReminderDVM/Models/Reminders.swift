//
//  Reminders.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 20/04/23.
//

import Foundation

struct Reminder : Identifiable {
    let id : String = UUID().uuidString
    let title : String
    let body : String
    let date : Date
    let status : Bool
}

/*struct ReminderList{
    static var list = [
        Reminder(title: "Buy Tickets", body: "buy them early!", date: Date(timeIntervalSinceNow: 15), status: true),
        Reminder(title: "Donate organs", body: "Nirmaan calling", date: Date(timeIntervalSinceNow: 15), status: true),
        Reminder(title: "Prepare for midsems", body: "10cg this sem", date: Date(timeIntervalSinceNow: 15), status: false),
        Reminder(title: "Sleep", body: "pepe feels bad man", date: Date(timeIntervalSinceNow: 15), status: false),
    ]
}*/
