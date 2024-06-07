//
//  LoginScreenViewModel.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import Foundation
import FirebaseAuth

class LoginScreenViewModel: ObservableObject {
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
    
    init() {
        let _ = FirebaseService.shared
        authManager = AuthManager.shared
        isAuth = authManager.isAuth
        firestore = FirebaseFirestore()
    }
    
    func loginButton() {
        if emailTextfield.isEmpty {
            alertMessage = "Email cant be empty"
            isShowingAlert = true
        } else if passwordTextfield.isEmpty {
            alertMessage = "Password cant be empty"
            isShowingAlert = true
        } else if passwordTextfield.count < 8 {
            alertMessage = "Password must contains 8 characters or more!"
            isShowingAlert = true
        } else {   
            signIn()
        }
    }
    
    func signIn() {
        authManager.signInUsingEmail(email: emailTextfield, password: passwordTextfield) { results in
            switch results {
            case .success(let authDataResult):
                self.authManager.currentUser = authDataResult.user
                self.updateUser(authDataResult.user)
                self.isAuth = true
            case .failure(let failure):
                self.alertMessage = failure.localizedDescription
                self.isShowingAlert = true
            }
        }
    }
    
    func updateUser(_ user: User) {
        firestore.updateUser(user) { results in
            switch results {
            case .success:
                break
            case .failure(let failure):
                self.alertMessage = failure.localizedDescription
                self.isShowingAlert = true
            }
        }
    }
}
