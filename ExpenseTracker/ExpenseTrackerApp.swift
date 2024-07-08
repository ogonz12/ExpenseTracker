//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Orlando Gonzalez on 7/3/24.
//

import SwiftUI
import FirebaseCore

@main
struct ExpenseTrackerApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
    }
}
