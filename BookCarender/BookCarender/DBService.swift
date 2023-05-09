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
        let mstBook = "create table if not exists mst_book(id integer primary key autoincrement, book_title text, book_image text, book_description text, book_image text, created_time integer, update_time integer, update_count integer, delete_flg integer);"
            createTable(insertSqlCode: mstBook)
            
    }
    private func createTable(insertSqlCode: String) {
        var createTable : OpaquePointer? = nil
                if sqlite3_prepare_v2(self.db, insertSqlCode, -1, &createTable, nil) == SQLITE_OK {
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
