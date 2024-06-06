//
//  FirebaseFirestoreProtocol.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 06/06/24.
//

import Foundation
import FirebaseAuth

protocol FirebaseFirestoreProtocol {
    func fetchUsers(_ completion: @escaping (Result<[UserModel], Error>) -> Void)
    func fetchUser(_ user: User, _ completion: @escaping (Result<UserModel, Error>) -> Void)
    func createUser(_ user: User, _ completion: @escaping (Result<Bool, Error>) -> Void)
    func updateUser(_ user:  User, _ completion: @escaping (Result<Bool, Error>) -> Void)
    func deleteUser(_ user: User, _ completion: @escaping (Result<Bool, Error>) -> Void)
}
