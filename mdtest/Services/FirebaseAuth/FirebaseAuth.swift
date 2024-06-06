//
//  FirebaseAuth.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 06/06/24.
//

import Foundation
import FirebaseAuth

class FirebaseAuth: FirebaseAuthProtocol {
    private let auth: Auth
    
    init(_ _auth: Auth = Auth.auth()) {
        auth = _auth
        auth.useAppLanguage()
    }
    
    func signUpUsingEmail(email: String, password: String, _ completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let authResult = authResult else {
                completion(.failure(FirebaseServiceError.unknownError))
                return
            }
            
            completion(.success(authResult))
        }
        
    }
    
    func signInUsingEmail(email: String, password: String, _ completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let authResult = authResult else {
                completion(.failure(FirebaseServiceError.unknownError))
                return
            }
            
            completion(.success(authResult))
        }
    }
    
    func signOut(_ completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    func verifyEmail(_ currentUser: User, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        currentUser.sendEmailVerification { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func updateUserProfile(_ userModel: UserModel, _ currentUser: User, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        let changeRequest = currentUser.createProfileChangeRequest()
        
        changeRequest.displayName = userModel.name
        if let photoURL = URL(string: userModel.photoURL) {
            changeRequest.photoURL = photoURL
        }
        
        changeRequest.commitChanges { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func resetPassword(email: String, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func getCurrentUser(_ completion: @escaping (Result<User, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(AuthErrorCode.userNotFound as! Error))
            return
        }
        
        completion(.success(currentUser))
    }
}
