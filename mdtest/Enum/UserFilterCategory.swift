//
//  UserFilterCategory.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import Foundation

enum UserFilterCategory: CaseIterable {
    case byNameAsc, byNameDesc, byEmailAsc, byEmailDesc, isVerified, isNotVerified
    
    var description: String {
        switch self {
        case .byNameAsc:
            "Name A-Z"
        case .byNameDesc:
            "Name Z-A"
        case .byEmailAsc:
            "Email A-Z"
        case .byEmailDesc:
            "Email Z-A"
        case .isVerified:
            "Email Verified"
        case .isNotVerified:
            "Email Not Verified"
        }
    }
}
