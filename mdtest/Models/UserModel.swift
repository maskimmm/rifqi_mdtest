//
//  UserModel.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 06/06/24.
//

import Foundation

struct UserModel: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String = String()
    var email: String = String()
    var photoURL: String = String()
    var isEmailVerified: Bool = false
    var createdAt: Date = Date.now
    var updatedAt: Date = Date.now
    
    func toDictionary() -> [String: Any] {
        return [
            "uid" : id,
            "name" : name,
            "email" : email,
            "photoURL": photoURL,
            "isEmailVerified" : isEmailVerified,
            "createdAt" : createdAt,
            "updatedAt" : updatedAt
        ]
    }
}
