//
//  LoginScreenView.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import SwiftUI

struct LoginScreenView: View {
    @StateObject private var vm = LoginScreenViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Welcome Back!")
                        .font(.system(.largeTitle, weight: .heavy))
                }
                .foregroundStyle(Color(UIColor.label))
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Text("Login to Continue")
                        .font(.system(.title3, weight: .medium))
                }
                .foregroundStyle(Color(UIColor.label))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.system(.callout, weight: .medium))
                    TextField("Enter your email..", text: $vm.emailTextfield)
                        .textFieldStyle(.roundedBorder)
                }
                .foregroundStyle(Color(UIColor.label))
                .padding(.bottom, 10)
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.system(.callout, weight: .medium))
                    SecureField("Enter your password", text: $vm.passwordTextfield)
                        .textFieldStyle(.roundedBorder)
                }
                .foregroundStyle(Color(UIColor.label))
                .padding(.bottom, 10)
                .padding(.bottom)
                
                
                VStack {
                    Button("Login") {
                        vm.loginButton()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.horizontal, 50)
                    .background(Color(UIColor.systemBlue))
                    .foregroundStyle(Color(UIColor.systemBackground))
                    .fontWeight(.bold)
                    .clipShape(Capsule())
                }
                
                HStack(spacing: 0) {
                    Text("Dont have an account? ")
                    Button {
                        vm.isShowingRegisterScreen = true
                    } label: {
                        Text("Register!")
                    }
                }
                .font(.system(.subheadline))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                
                Button {
                    vm.isShowingResetPasswordScreen = true
                } label: {
                    Text("Forgot Your Password?")
                }
                .font(.system(.subheadline))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 10)
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $vm.isAuth) {
                HomepageScreenView()
            }
            .navigationDestination(isPresented: $vm.isShowingRegisterScreen) {
                RegistrationScreenView()
            }
            .navigationDestination(isPresented: $vm.isShowingResetPasswordScreen) {
                ResetPasswordScreenView()
            }
            .onAppear {
                vm.isAuth = AuthManager.shared.isAuth
            }
            .alert(vm.alertMessage, isPresented: $vm.isShowingAlert) {
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginScreenView()
    }
}
