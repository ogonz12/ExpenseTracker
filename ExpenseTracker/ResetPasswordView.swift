//
//  ForgotPasswordView.swift
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
            Color.green
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
            
            VStack {
                Spacer()
                Text("Reset Password")
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
                
                Button(action: {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        if let error = error {
                            print("Error sending password reset email: \(error.localizedDescription)")
                            showErrorAlert.toggle()
                        } else {
                            showSuccessAlert.toggle()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }) {
                    Text("Send Reset Link")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(10)
                }
                .alert(isPresented: $showErrorAlert) {
                    Alert(title: Text("Error"), message: Text("Failed to send reset link. Please try again."), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $showSuccessAlert) {
                    Alert(title: Text("Success"), message: Text("Password reset link sent! Check your email."), dismissButton: .default(Text("OK")))
                }
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ResetPasswordView()
}
