//
//  ReminderView.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 20/04/23.
//

import SwiftUI

struct ReminderView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var reminderlistModel : ReminderListModel
    @State var titlefield : String = ""
    @State var bodyfield : String = ""
    @State var datefield : Date = Date()
    @State var statusfield : Bool = false
    var index : Int?
    
    init(index: Int) {
        self.index = index
        /*
        self._titlefield = State(initialValue: "\(reminderlistModel.reminders[index].title)")
        self._bodyfield = State(initialValue: "\(reminderlistModel.reminders[index].body)")
        self._datefield = State(initialValue: DateFormatter().date(from: "\(reminderlistModel.reminders[index].date)")!)
        self._statusfield = State(initialValue: Bool("\(reminderlistModel.reminders[index].status)")!)
        */
    }
    let notify = NotificationHelper()
    // create a uuid from current date and title , body combination
    // need this for cancelling specific notification or rescheduling them later
    // TODO: implement the non hacky way (maybe store the UUID of a notification request in the data model
    
    func updateReminder(){
        // need this condition to create my_hacky_uuid
        if(titlefield.count > 3){
            notify.askPermission()
            let my_hacky_uuid : String = "\(titlefield)\(bodyfield)\(datefield)"
            reminderlistModel.updateItem(index: index!, title: titlefield, body: bodyfield, date: datefield, status: statusfield)
            notify.addNotification(id: my_hacky_uuid, date: datefield, title: titlefield, body: bodyfield)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
            ScrollView{
                VStack(spacing: 10){
                    TextField("Title", text: $titlefield)
                        .padding(.horizontal)
                        .frame(height: 50)
                    TextField("Body", text: $bodyfield)
                        .padding(.horizontal)
                        .frame(height: 50)
                    DatePicker("Date", selection: $datefield, in: Date()...)
                        .padding(.all)
                    Toggle("Completed:", isOn: $statusfield)
                        .padding(.horizontal)
                        .frame(height: 50)
                    Spacer()
                    Button(action: updateReminder ,label:{
                        Text("Update")
                            .foregroundColor(Color.white)
                            .frame(width: 150,height: 50)
                            .background(Color.blue)
                            .cornerRadius(50.0)
                    })
                }
                .padding(30)
            }.navigationTitle("Edit reminder")
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var value : Int = 1
    static var previews: some View {
        NavigationView{
            ReminderView(index: value)
        }
        .environmentObject(ReminderListModel())
    }
}
