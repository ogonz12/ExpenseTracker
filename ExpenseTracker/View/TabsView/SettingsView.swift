//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Wesley John on 7/19/24.
//  Added Log Out button by Orlando

import SwiftUI
import Firebase

struct SettingsView: View {
    @AppStorage("isSignedIn") private var isSignedIn: Bool = false
    @State private var isDarkModeOn = false
    @State private var notificationsEnabled = false

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Display Settings")
                        .font(.title2)
                        .padding(.bottom, 5)

                    Toggle(isOn: $isDarkModeOn) {
                        Text("Dark Mode")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onChange(of: isDarkModeOn) { newValue in
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = newValue ? .dark : .light
                    }
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Notifications")
                        .font(.title2)
                        .padding(.bottom, 5)

                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Notifications")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: AboutView()) {
                    Text("About Us")
                        .font(.headline)
                        .foregroundColor(.accentColor) // Uses the accent color of the app
                        .padding()
                        .background(Color(UIColor.systemGray6)) // Uses system-defined gray color
                        .cornerRadius(10)
                }
                .padding()

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
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
