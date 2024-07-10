//
//  LoginPage.swift
//  ExpenseTracker
//
//  Created by Orlando Gonzalez on 7/3/24.
//

import SwiftUI
import Firebase
import GoogleSignIn


struct LoginPage: View {
    @State private var isCreateAccountViewPresented = false
    @State private var isPasswordResetViewPresented = false
    @State private var isPasswordCorrect: Bool = false
    @State private var showErrorAlert: Bool = false

    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
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
                    Text("Welcome back")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 60)

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
                        Button(action: {
                            isPasswordResetViewPresented.toggle()
                        }) {
                            Spacer()
                            Text("Forgot Password?")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 45)
                        .sheet(isPresented: $isPasswordResetViewPresented) {
                            ResetPasswordView()
                        }
                    }

                    Button(action: {
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                print(error.localizedDescription)
                                email = ""
                                password = ""
                                showErrorAlert.toggle()
                            }
                            if let _ = authResult {
                                isPasswordCorrect = true
                            }
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .bold()
                    }
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.5))
                            .padding(.horizontal)

                        Text("Or continue with")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.5))
                            .padding(.horizontal)
                    }
                    .padding(.top)

                    HStack {
                        Button(action: {
                            signInWithGoogle()
                        }) {
                            Image("google")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .padding(.horizontal, 40)
                        }
                        // would have also implemented but i don't have an apple dev acc
                        Image("apple")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(.bottom, 10)
                            .padding(.horizontal, 40)
                    }.padding(.top, 40)

                    Spacer()

                    Text("Don't have an account?")
                        .foregroundColor(.white)
                    Button(action: {
                        isCreateAccountViewPresented.toggle()
                    }) {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                            .bold()
                    }
                    .sheet(isPresented: $isCreateAccountViewPresented) {
                        NewAccountView()
                    }
                }

                NavigationLink(destination: HomePage(), isActive: $isPasswordCorrect) {
                    EmptyView()
                }
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Login Error"), message: Text("Invalid email or password. Please try again."), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let presentingViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("There is no root view controller!")
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Error during Google authentication!")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                isPasswordCorrect = true
            }
        }
    }
}

#Preview {
    LoginPage()
}
