//
//  LoginPage.swift
//  ExpenseTracker
//
//  Created by Orlando Gonzalez on 7/8/24.
//
import SwiftUI
import FirebaseAuth

struct ResetPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var showSuccessAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Reset Password")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.all)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Enter your email address below and we'll send you a link to reset your password.")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                        
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                            TextField("Email", text: $email)
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    
                    Button(action: {
                        Auth.auth().sendPasswordReset(withEmail: email) { error in
                            if let error = error {
                                print("Error sending password reset email: \(error.localizedDescription)")
                                showErrorAlert.toggle()
                            } else {
                                showSuccessAlert.toggle()
                            }
                        }
                    }) {
                        Text("Send Reset Link")
                            .foregroundColor(.black)
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.vertical)
                    }
                    .alert(isPresented: $showErrorAlert) {
                        Alert(title: Text("Error"), message: Text("Failed to send reset link. Please try again."), dismissButton: .default(Text("OK")))
                    }
                    .alert(isPresented: $showSuccessAlert) {
                        Alert(title: Text("Success"), message: Text("Password reset link sent! Check your email."), dismissButton: .default(Text("OK")))
                    }
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .padding(.bottom)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    ResetPasswordView()
}
