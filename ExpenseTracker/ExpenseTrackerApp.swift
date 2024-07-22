//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Orlando Gonzalez on 7/3/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SwiftData

@main
struct ExpenseTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isSignedIn") private var isSignedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isSignedIn {
                HomePage()
            } else {
                LoginPage()
            }
        }
        .modelContainer(for: [Transaction.self])
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

