//
//  ReminderListModel.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 26/04/23.
//

import Foundation

class ReminderListModel : ObservableObject{
    
    @Published var reminders : [Reminder] = []
    let db = DBHelper()
    
    init(){
        getItems()
    }
    
    func getItems(){
        self.reminders = self.db.read()
    }
    
    func addItem(title: String, body: String, date: Date){
        //let newItem = Reminder(title: title, body: body, date: date, status: false)
        //reminders.append(newItem)
        self.db.insert(title: title, body: body, date: date, status: false)
        self.reminders = self.db.read()
    }
    
    /*
    func deleteItem(indexSet: IndexSet){
        for index in indexSet {
            self.db.deleteByID(id: self.reminders[index].id)
            self.reminders = self.db.read()
            //self.reminders.remove(at: index)
        }
        //reminders.remove(atOffsets: indexSet)
    }*/
    func updateItem(index: Int, title: String, body: String, date: Date, status: Bool){
        self.db.update(id: self.reminders[index].id, title: title, body: body, date: date, status: status)
        self.reminders = self.db.read()
    }
    
    func deleteItem(index: Int){
        self.db.deleteByID(id: self.reminders[index].id)
        self.reminders = self.db.read()
    }
    func toggle_status (index: Int){
        var newstatus : Bool = true
        if(self.reminders[index].status){
            newstatus = false
        }
        self.db.toggle_status(id: self.reminders[index].id, status: newstatus)
        self.reminders = self.db.read()
    }
    
}
