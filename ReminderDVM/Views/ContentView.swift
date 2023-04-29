//
//  ContentView.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 20/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var reminderlistModel : ReminderListModel
    
    var body: some View {
            VStack{
                List{
                    ForEach(Array(reminderlistModel.reminders.enumerated()), id: \.offset){ index, item in
                        NavigationLink(destination: ReminderView(index: index),label: {
                            CardView(Reminder: item)
                        })
                        .swipeActions(edge: .leading) {
                                Button {
                                    reminderlistModel.toggle_status(index: index)
                                } label: {
                                    Label("Toggle", systemImage: "plus.circle")
                                }
                                .tint(.indigo)
                        }
                        .swipeActions(edge: .trailing) {
                                Button {
                                    reminderlistModel.deleteItem(index: index)
                                } label: {
                                    Label("Delete", systemImage: "minus.circle.fill")
                                }
                                .tint(.red)
                        }
                    }
                    //.onDelete(perform: reminderlistModel.deleteItem)
                }
                NavigationLink("Add", destination: AddReminderView())
                // add task button
                /*Button(action: {}) {
                          HStack {
                            Image(systemName: "plus.circle.fill")
                              .resizable()
                              .frame(width: 20, height: 20)
                            Text("New Task")
                          }
                        }
                        .padding()*/
            }
        .navigationTitle("Reminders")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }
        .environmentObject(ReminderListModel())
    }
}

struct CardView : View {
    var Reminder : Reminder
    var body : some View {
        HStack(spacing: 20){
            Image(systemName: Reminder.status ? "checkmark.circle.fill" : "circle")
                .imageScale(.medium)
            VStack(alignment: .leading){
                Text(Reminder.title)
                    .font(.headline)
                    
                Text(Reminder.body)
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                
            }.padding(.vertical)
        }
    }
}
