//
//  Reminders.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 20/04/23.
//

import Foundation

struct Reminder : Identifiable {
    let id : Int
    let title : String
    let body : String
    let date : Date
    let status : Bool
}
