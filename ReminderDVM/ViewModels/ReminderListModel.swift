//
//  ReminderListModel.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 26/04/23.
//

import Foundation

class ReminderListModel : ObservableObject{
    
    @Published var reminders : [Reminder] = []
    
    init(){
        getItems()
    }
    
    func getItems(){
        let newItems = [
            Reminder(title: "Buy Tickets", body: "buy them early!", date: Date(timeIntervalSinceNow: 15), status: true),
            Reminder(title: "Donate organs", body: "Nirmaan calling", date: Date(timeIntervalSinceNow: 15), status: true),
            Reminder(title: "Prepare for midsems", body: "10cg this sem", date: Date(timeIntervalSinceNow: 15), status: false),
            Reminder(title: "Sleep", body: "pepe feels bad man", date: Date(timeIntervalSinceNow: 15), status: false),
        ]
        reminders.append(contentsOf: newItems)
    }
    
    func addItem(title: String, body: String, date: Date){
        let newItem = Reminder(title: title, body: body, date: date, status: false)
        reminders.append(newItem)
    }
    
    func deleteItem(indexSet: IndexSet){
        reminders.remove(atOffsets: indexSet)
    }
    
}
