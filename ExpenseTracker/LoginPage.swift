import SwiftUI
import Firebase

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
                        .padding()
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
               
                   
                    
                    HStack{
                        Button(action: {
                            isPasswordResetViewPresented.toggle()
                        }) {
                            Spacer()
                            Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        }.padding(.trailing, 45)
                        .sheet(isPresented: $isPasswordResetViewPresented) {
                            ForgotPasswordView()
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
}


#Preview {
    LoginPage()
}
