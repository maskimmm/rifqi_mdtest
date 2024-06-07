//
//  AuthManager.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    let firebaseAuth: FirebaseAuth = FirebaseAuth()
    
    var isAuth: Bool = false
    var currentUser: User?
    
    func signUpUsingEmail(email: String, password: String, completion: @escaping (Result<User, any Error>) -> Void) {
        firebaseAuth.signUpUsingEmail(email: email, password: password) { results in
            switch results {
            case .success(let authDataResult):
                self.currentUser = authDataResult.user
                completion(.success(authDataResult.user))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func signInUsingEmail(email: String, password: String, completion: @escaping (Result<AuthDataResult, any Error>) -> Void) {
        firebaseAuth.signInUsingEmail(email: email, password: password) { results in
            switch results {
            case .success(let authDataResult):
                self.currentUser = authDataResult.user
                completion(.success(authDataResult))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func resetPassword(_ email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        firebaseAuth.resetPassword(email: email, completion)
    }
    
    func verifyEmail(_ currentUser: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        firebaseAuth.verifyEmail(currentUser, completion)
    }
    
//    func signOut(_ completion: @escaping (Result<Bool, Error>) -> Void)
//    func updateUserProfile(_ userModel: UserModel, _ currentUser: User, _ completion: @escaping (Result<Bool, Error>) -> Void)
//    func getCurrentUser(_ completion: @escaping (Result<User, Error>) -> Void)
}
