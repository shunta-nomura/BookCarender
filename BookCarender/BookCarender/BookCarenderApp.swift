//
//  BookCarenderApp.swift
//  BookCarender
//
//  Created by 野村俊太 on 2022/08/02.
//

import SwiftUI

@available(iOS 16.0, *)
@main
struct BookCarenderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            SwiftUiView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let db = DBHelper()
        db.creatDb()
        db.createTable()
        return true
    }
}
