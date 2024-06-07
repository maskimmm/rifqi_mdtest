//
//  FirebaseService.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 06/06/24.
//

import Foundation
import FirebaseCore

enum FirebaseServiceError: Error {
    case unknownError
    
    var description: String {
        switch self {
        case .unknownError:
            return "Unknown Error Occured."
        }
    }
}

class FirebaseService {  
    static let shared = FirebaseService()
    
    init() {
        FirebaseApp.configure()
    }
}
