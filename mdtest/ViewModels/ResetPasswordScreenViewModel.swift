//
//  ResetPasswordScreenViewModel.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import Foundation

class ResetPasswordScreenViewModel: ObservableObject {
    var authManager: AuthManager
    
    @Published var isShowingAlert: Bool = false {
        didSet {
            if !isShowingAlert {
                alertMessage = String()
            }
        }
    }
    @Published var alertMessage: String = String()
    @Published var emailTextfield: String = String()
    
    init() {
        let _ = FirebaseService.shared
        authManager = AuthManager.shared
    }
    
    func resetPassword() {
        if emailTextfield.isEmpty {
            alertMessage = "Email cant be empty"
            isShowingAlert = true
        } else {
            authManager.resetPassword(emailTextfield) { results in
                switch results {
                case .success:
                    self.alertMessage = "Reset password confirmation sent to your email."
                    self.isShowingAlert = true
                case .failure(let failure):
                    self.alertMessage = failure.localizedDescription
                    self.isShowingAlert = true
                }
            }
        }
    }
}
