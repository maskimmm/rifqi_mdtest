//
//  RegistrationScreenView.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import SwiftUI

struct RegistrationScreenView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = RegistrationScreenViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to MDTest!")
                    .font(.system(.largeTitle, weight: .heavy))
            }
            .foregroundStyle(Color(UIColor.label))
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Text("Create Your Account")
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
                SecureField("Enter your password..", text: $vm.passwordTextfield)
                    .textFieldStyle(.roundedBorder)
            }
            .foregroundStyle(Color(UIColor.label))
            .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                Text("Confirmation Password")
                    .font(.system(.callout, weight: .medium))
                SecureField("Enter your password again..", text: $vm.confirmPasswordTextfield)
                    .textFieldStyle(.roundedBorder)
            }
            .foregroundStyle(Color(UIColor.label))
            .padding(.bottom, 10)
            .padding(.bottom)
            
            
            VStack {
                Button("Register") {
                    vm.registerButton()
                    if vm.isAuth {
                        dismiss()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.horizontal, 50)
                .background(Color(UIColor.systemBlue))
                .foregroundStyle(Color(UIColor.systemBackground))
                .fontWeight(.bold)
                .clipShape(Capsule())
            }
        }
        .padding(.horizontal)
        .alert(vm.alertMessage, isPresented: $vm.isShowingAlert) {
            if vm.alertMessage == "Verification Sent to your email." {
                Button("Continue") {
                    vm.isAuth = true
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    RegistrationScreenView()
}
