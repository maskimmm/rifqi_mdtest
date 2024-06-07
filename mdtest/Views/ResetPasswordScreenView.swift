//
//  ResetPasswordScreenView.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import SwiftUI

struct ResetPasswordScreenView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = ResetPasswordScreenViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Forget Password")
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
            .padding(.bottom)
            
            
            VStack {
                Button("Submit") {
                    vm.resetPassword()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.horizontal, 50)
                .background(Color(UIColor.systemBlue))
                .foregroundStyle(Color(UIColor.systemBackground))
                .fontWeight(.bold)
                .clipShape(Capsule())
            }
            .alert(vm.alertMessage, isPresented: $vm.isShowingAlert) {
                if vm.alertMessage.contains("Reset password confirmation sent to your email.") {
                    Button("Continue") {
                     dismiss()
                    }
                }
            }
        }
        .padding(.all)
    }
}

#Preview {
    ResetPasswordScreenView()
}
