//
//  BookCarenderApp.swift
//  BookCarender
//
//  Created by 野村俊太 on 2022/08/02.
//

import SwiftUI

@main
struct BookCarenderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("起動処理完了")

        return true
    }
}
