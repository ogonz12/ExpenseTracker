//
//  NewAccountView.swift
//  ExpenseTracker
//
//  Created by Orlando Gonzalez on 7/3/24.
//

import SwiftUI
import FirebaseAuth

struct NewAccountView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
            
            VStack {
                Spacer()
                Text("Create New Account")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                HStack {
                    Image(systemName: "mail")
                        .foregroundColor(.gray)
                    TextField("Email", text: $email)
                        .foregroundColor(.black)
                        .padding()
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("Password", text: $password)
                        .foregroundColor(.black)
                        .padding()
                        .cornerRadius(10)
                }
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 130, height: 50)
                            .background(Color.gray)
                            .cornerRadius(10)
                            
                    }
                    Spacer()
                    Button(action: {
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                print("Error creating user: \(error.localizedDescription)")
                                return
                            }
                            if let authResult = authResult {
                                print("User created: \(authResult.user.uid)")
                            }
                        }
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView()
    }
}
