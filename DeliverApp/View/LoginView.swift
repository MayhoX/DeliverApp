//
//  LoginView.swift
//  DeliverApp
//
//  Created by Evan Wong on 14/1/2024.
//

import SwiftUI


struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var faceIDModel: FaceIDModel

    var body: some View {
        NavigationStack{
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 120)
                    .padding(.vertical, 32)
            
                VStack{
                    TextField("Email", text: $email)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(UIColor.label), lineWidth: 3)
                        )
                        .cornerRadius(10.0)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .padding(.bottom, 5)
                    
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(UIColor.label), lineWidth: 3)
                        )
                        .cornerRadius(10.0)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .padding(.bottom, 20)
                    
                    
                    if viewModel.userSession != nil {
                        Button(action: {
                            faceIDModel.evaluatePolicy()
                        }) {
                            HStack {
                                Image(systemName: "faceid")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Authenticate with Face ID")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }

                    
                    Button(action: {
                        Task {
                            try await viewModel.signIn(email: email, password: password)
                        }
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 32, height: 52)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                            .disabled(!formIsValid)
                            .opacity(formIsValid ? 1.0 : 0.5)

                    }

                    
                    Spacer()
                    
                    
                    NavigationLink {
                        RegisterView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack{
                            Text("Don't have an account?")
                            Text("Sign up")
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 14))
                    }
                }
                
            }
        }
    }
}

extension LoginView: AuthProtocol {
    var formIsValid: Bool {
        return !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty &&
        password.count > 5
    }
}

#Preview {
    LoginView()
}

