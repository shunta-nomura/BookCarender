//
//  DBService.swift
//  BookCarender
//
//  Created by 野村俊太 on 2022/08/19.
//

import Foundation
import SQLite3

class DBHelper {
    var db : OpaquePointer?
    var path : String = "mydb.sqlite"
    init() {
        self.db = self.creatDb()
        self.createTable()
    }
    func creatDb() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("mydb.sqlite")
        var db : OpaquePointer? = nil
                if sqlite3_open(filePath.path, &db) == SQLITE_OK {
            let documentDirPath = NSSearchPathForDirectoriesInDomains(
                FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            print("Simulator location \(documentDirPath)")
                        print("Db has been created with path = \(filePath)")
            return db
        } else {
            print("Creating DB Error.")
            return nil
        }
            }
        func createTable() {
        let query = "create table if not exists grade(id integer primary key autoincrement, name text, result text, list text);"
        var createTable : OpaquePointer? = nil
                if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("Table created")
            } else {
                print("Table create fail")
            }
                    } else {
            print("Preparation fail")
        }
    }
}
