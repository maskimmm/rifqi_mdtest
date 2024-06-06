//
//  FirebaseAuthProtocol.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 06/06/24.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthProtocol {
    func signUpUsingEmail(email: String, password: String, _ completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signInUsingEmail(email: String, password: String, _ completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signOut(_ completion: @escaping (Result<Bool, Error>) -> Void)
    func verifyEmail(_ currentUser: User, _ completion: @escaping (Result<Bool, Error>) -> Void)
    func updateUserProfile(_ userModel: UserModel, _ currentUser: User, _ completion: @escaping (Result<Bool, Error>) -> Void)
    func resetPassword(email: String, _ completion: @escaping (Result<Bool, Error>) -> Void)
    func getCurrentUser(_ completion: @escaping (Result<User, Error>) -> Void)
}
