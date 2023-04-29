//
//  AddReminderView.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 27/04/23.
//

import SwiftUI

struct AddReminderView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var reminderlistModel : ReminderListModel
    @State var titlefield : String = ""
    @State var bodyfield : String = ""
    @State var datefield : Date = Date()
    let notify = NotificationHelper()
    // create a uuid from current date and title , body combination
    // need this for cancelling specific notification or rescheduling them later
    // TODO: implement the non hacky way (maybe store the UUID of a notification request in the data model
    
    func saveReminder(){
        // need this condition to create my_hacky_uuid
        if(titlefield.count > 3){
            notify.askPermission()
            let my_hacky_uuid : String = "\(titlefield)\(bodyfield)\(datefield)"
            reminderlistModel.addItem(title: titlefield, body: bodyfield, date: datefield)
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
                    Spacer()
                    Button(action: saveReminder ,label:{
                        Text("Save")
                            .foregroundColor(Color.white)
                            .frame(width: 150,height: 50)
                            .background(Color.blue)
                            .cornerRadius(50.0)
                    })
                }
                .padding(30)
            }.navigationTitle("Add reminder")
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddReminderView()
        }
        .environmentObject(ReminderListModel())
    }
}
