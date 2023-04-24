//
//  ContentView.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 20/04/23.
//

import SwiftUI

struct ContentView: View {
    var reminderlist: [Reminder] = ReminderList.list
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(reminderlist, id: \.id){ item in
                        NavigationLink(destination: ReminderView(element: item),label: {
                            CardView(Reminder: item)
                        })
                    }
                }
                Button(action: {}) {
                          HStack {
                            Image(systemName: "plus.circle.fill")
                              .resizable()
                              .frame(width: 20, height: 20)
                            Text("New Task")
                          }
                        }
                        .padding()
            }
        .navigationTitle("Reminders")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
