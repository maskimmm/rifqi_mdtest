//
//  FirebaseFirestore.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 05/06/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseFirestore: FirebaseFirestoreProtocol {
    private let db: Firestore
    
    init(_ _db: Firestore = Firestore.firestore()) {
        let _ = FirebaseService.shared
        db = _db
    }
    
    func fetchUsers(_ completion: @escaping (Result<[UserModel], Error>) -> Void) {
        db.collection("Users").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            }

            if let snapshot = snapshot {
                var users: [UserModel] = [UserModel]()
                let dateFormatter = DateFormatter()
                for document in snapshot.documents {
                    let data = document.data()
                    let user = UserModel(
                        id: UUID(uuidString: String(describing: data["id"]!)) ?? UUID(),
                        name: String(describing: data["name"]!),
                        email: String(describing: data["email"]!),
                        photoURL: String(describing: data["photoURL"]!),
                        isEmailVerified: data["isEmailVerified"]! as? Bool ?? false,
                        createdAt: dateFormatter.date(from: String(describing: data["createdAt"]!)) ?? Date.now,
                        updatedAt: dateFormatter.date(from: String(describing: data["updatedAt"]!)) ?? Date.now
                    )
                    users.append(user)
                }
                
                completion(.success(users))
            } else {
                completion(.failure(FirebaseServiceError.unknownError))
            }
        }

    }
    
    func fetchUser(_ user: User, _ completion: @escaping (Result<UserModel, Error>) -> Void) {
        db.collection("Users").document(user.uid).getDocument(completion: { snapshot, error in
//            switch result {
//            case .success(let success):
//                break
////                completion(.success(success))
//            case .failure(let failure):
//                completion(.failure(failure))
//            }
            if let error = error {
                completion(.failure(error))
            }
            
            if let snapshot = snapshot, let data = snapshot.data() {
                let dateFormatter = DateFormatter()
                let user = UserModel(
                    id: UUID(uuidString: String(describing: data["id"])) ?? UUID(),
                    name: String(describing: data["name"]),
                    email: String(describing: data["email"]),
                    photoURL: String(describing: data["photoURL"]),
                    isEmailVerified: data["isEmailVerified"] as? Bool ?? false,
                    createdAt: dateFormatter.date(from: String(describing: data["createdAt"])) ?? Date.now,
                    updatedAt: dateFormatter.date(from: String(describing: data["updatedAt"])) ?? Date.now
                )
                
                completion(.success(user))
            }
        })
    }
    
    func createUser(_ user: User, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        db.collection("Users").document(user.uid).setData (
            [
                "id" : user.uid,
                "name" : user.displayName ?? "User\(Int.random(in: 00000...99999))",
                "email" : user.email ?? "",
                "photoURL" : String(describing: user.photoURL),
                "isEmailVerified" : user.isEmailVerified,
                "createdAt" : FieldValue.serverTimestamp(),
                "updatedAt" : FieldValue.serverTimestamp()
            ]
        ) { error in
            if let error = error {
                completion(.failure(error))
            }
            
            completion(.success(true))
        }
    }
    
    func updateUser(_ user:  User, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        db.collection("Users").document(user.uid).updateData([
                "name" : user.displayName ?? "",
                "email" : user.email ?? "",
                "photoURL" : String(describing: user.photoURL),
                "isVerified" : user.isEmailVerified,
                "updatedAt" : FieldValue.serverTimestamp()
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func deleteUser(_ user: User, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        db.collection("Users").document(user.uid).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
