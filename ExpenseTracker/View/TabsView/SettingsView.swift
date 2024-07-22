//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Aday Devora on 7/19/24.
//  Added Log Out button by Orlando

import SwiftUI
import Firebase

struct SettingsView: View {
    @AppStorage("isSignedIn") private var isSignedIn: Bool = false

    var body: some View {
        VStack {
            Button(action: {
                signOut()
            }) {
                Text("Log Out")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .navigationTitle("Settings")
    }

    private func signOut() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

#Preview {
    SettingsView()
}
