//
//  HomepageScreenViewModel.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import Foundation

class HomepageScreenViewModel: ObservableObject {
    var authManager: AuthManager
    let firestore: FirebaseFirestore
    
    @Published var isAuth: Bool {
        didSet {
            authManager.isAuth = isAuth
        }
    }
    @Published var isShowingAlert: Bool = false {
        didSet {
            if !isShowingAlert {
                alertMessage = String()
            }
        }
    }
    @Published var alertMessage: String = String()
    
    @Published var users: [UserModel] = [UserModel]() {
        didSet {
            tempUsers = users
        }
    }
    @Published var tempUsers: [UserModel] = [UserModel]()
    
    @Published var searchText: String = String() {
        didSet {
            if searchText.isEmpty {
                tempUsers = users
            } else {
                tempUsers = users.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.email.lowercased().contains(searchText.lowercased())}
            }
        }
    }
    @Published var selectedFilter: UserFilterCategory = .byNameAsc {
        didSet {
            switch selectedFilter {
            case .byNameAsc:
                tempUsers = users.sorted(by: { prevItem, nextItem in
                    return prevItem.name < nextItem.name
                })
            case .byNameDesc:
                tempUsers = users.sorted(by: { prevItem, nextItem in
                    return prevItem.name > nextItem.name
                })
            case .byEmailAsc:
                tempUsers = users.sorted(by: { prevItem, nextItem in
                    return prevItem.email < nextItem.email
                })
            case .byEmailDesc:
                tempUsers = users.sorted(by: { prevItem, nextItem in
                    return prevItem.email > nextItem.email
                })
            case .isVerified:
                tempUsers = users.filter { $0.isEmailVerified == true }
            case .isNotVerified:
                tempUsers = users.filter { $0.isEmailVerified == false }
            }
        }
    }
    @Published var showActionSheet: Bool = false
    
    init() {
        let _ = FirebaseService.shared
        authManager = AuthManager.shared
        isAuth = authManager.isAuth
        firestore = FirebaseFirestore()
        fetchUsers()
    }
    
    func fetchUsers() {
        firestore.fetchUsers { results in
            switch results {
            case .success(let success):
                self.users = success
            case .failure(let failure):
                self.alertMessage = "Fetch User failed with error: \(failure.localizedDescription)"
                self.isShowingAlert = true
            }
        }
    }
}
