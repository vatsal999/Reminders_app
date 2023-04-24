//
//  ReminderView.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 20/04/23.
//

import SwiftUI

struct ReminderView: View {
    var element : Reminder
    @State private var itemtitle = "hello"
    @State private var itembody = "loremrsetnaioersgeoanmrosietnaywmfby;aysrgmaoierstnmeioangeimeirmi"
    
    var body: some View {
        Form{
            TextField("title", text: $itemtitle)
            TextField("body", text: $itembody)
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(element: ReminderList.list.first!)
    }
}
