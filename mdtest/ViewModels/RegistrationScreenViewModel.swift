//
//  RegistrationScreenViewModel.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import Foundation
import FirebaseAuth

class RegistrationScreenViewModel: ObservableObject {
    var authManager: AuthManager
    let firestore: FirebaseFirestore
    
    @Published var isAuth: Bool {
        didSet {
            authManager.isAuth = isAuth
        }
    }
    @Published var isShowingRegisterScreen: Bool = false
    @Published var isShowingResetPasswordScreen: Bool = false
    @Published var isShowingAlert: Bool = false {
        didSet {
            if !isShowingAlert {
                alertMessage = String()
            }
        }
    }
    @Published var alertMessage: String = String()
    @Published var emailTextfield: String = String()
    @Published var passwordTextfield: String = String()
    @Published var confirmPasswordTextfield: String = String()
    
    init() {
        let _ = FirebaseService.shared
        authManager = AuthManager.shared
        isAuth = authManager.isAuth
        firestore = FirebaseFirestore()
    }
    
    func registerButton() {
        if confirmPasswordTextfield != passwordTextfield {
            alertMessage = "Password and Password Confirmation must be same!"
            isShowingAlert = true
            return
        } else if passwordTextfield.count < 8 {
            alertMessage = "Password must contains 8 characters or more!"
            isShowingAlert = true
            return
        } else {
            signUp()
        }
        
    }
    
    func signUp() {
        authManager.signUpUsingEmail(email: emailTextfield, password: passwordTextfield) { results in
            switch results {
            case .success(let user):
                self.createUser(user)
                self.isAuth = true
            case .failure(let failure):
                self.alertMessage = failure.localizedDescription
                self.isShowingAlert = true
            }
        }
        
    }
    
    func createUser(_ user: User) {
        firestore.createUser(user) { results in
            switch results {
            case .success:
                self.verifyEmail(user)
            case .failure(let failure):
                self.alertMessage = failure.localizedDescription
                self.isShowingAlert = true
            }
        }
    }
    
    func verifyEmail(_ user: User) {
        if let currentUser = authManager.currentUser {
            authManager.verifyEmail(user) { results in
                switch results {
                case .success:
                    self.alertMessage = "Account created successfully. Verification email already sent to your email."
                    self.isShowingAlert = true
                case .failure(let failure):
                    self.alertMessage = failure.localizedDescription
                    self.isShowingAlert = true
                }
            }
        }
    }
}
