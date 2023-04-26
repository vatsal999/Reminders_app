//
//  DBhelper.swift
//  ReminderDVM
//
//  Created by Vatsal Agrawal on 26/04/23.
//

import Foundation
import SQLite3

class DBHelper {
    var db: OpaquePointer?
    let dbPath: String = "RemindersDVM.sqlite"
    
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func dateToSQLDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yy, hh:mma"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func SQLDateTodate(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)
    }
    
    func createDB() -> OpaquePointer?{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableQuery = "CREATE TABLE IF NOT EXISTS reminder(Id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,body TEXT,date TEXT, status INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Table successfully created")
            } else {
                print("Table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(title:String, body:String, date:Date, status:Bool){
        /*let reminders = read()
        for p in reminders
        {
            if p.id == id
            {
                return
            }
        }
        */
        
        var isEmpty = false
        if read().isEmpty {
            isEmpty = true
        }
        
        let insertStatementQuery = "INSERT INTO reminder (Id, title, body, date, status) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, insertStatementQuery, -1, &insertStatement, nil) == SQLITE_OK {
            if isEmpty {
                sqlite3_bind_int(insertStatement, 1, 1)
            }
            sqlite3_bind_text(insertStatement, 2, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (body as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (self.dateToSQLDate(date) as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 5, (status ? 1 : 0))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Reminder] {
           var reminderlist : [Reminder] = []
        
           let queryStatementString = "SELECT * FROM reminder;"
           var queryStatement: OpaquePointer? = nil
        
            if sqlite3_prepare_v2(self.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
               while sqlite3_step(queryStatement) == SQLITE_ROW {
                   let id = Int(sqlite3_column_int(queryStatement, 0))
                   let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                   let body = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                   let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                   let status = (sqlite3_column_int(queryStatement,4) == 0 ? false : true)
                   
                   reminderlist.append(Reminder(title: title, body: body, date: self.SQLDateTodate(date)!, status: status))
                   
                   print("Query Result:")
                   print("\(id) | \(title) | \(body) | \(date) | \(status)")
               }
           } else {
               print("SELECT statement could not be prepared")
           }
           sqlite3_finalize(queryStatement)
           return reminderlist
    }
    
    func deleteByID(id:Int) {
        let deleteStatementString = "DELETE FROM reminder WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        
        sqlite3_finalize(deleteStatement)
    }
}
