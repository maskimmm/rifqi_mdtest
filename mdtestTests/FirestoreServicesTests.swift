//
//  FirestoreServicesTests.swift
//  mdtestTests
//
//  Created by Rifqi Alhakim Hariyantoputera on 06/06/24.
//

import XCTest
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
@testable import mdtest

final class FirestoreServicesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        FirebaseApp.configure()
    }
    
    func testCreateUser() {
        let authConfig: Auth = Auth.auth()
        authConfig.useEmulator(withHost: "127.0.0.1", port: 9099)
        let auth = FirebaseAuth(authConfig)

        let dbConfig = Firestore.firestore()
        dbConfig.useEmulator(withHost: "127.0.0.1", port: 8080)
        dbConfig.settings.cacheSettings = MemoryCacheSettings()
        dbConfig.settings.isSSLEnabled = false
        let db = FirebaseFirestore(dbConfig)
        let expectation = expectation(description: "Success create user")
        
        auth.signInUsingEmail(email: "example@test.com", password: "12345678") { results in
            switch results {
            case .success(let authResult):
                db.createUser(authResult.user) { results in
                    switch results {
                    case .success(let success):
                        XCTAssertTrue(success)
                        expectation.fulfill()
                    case .failure(let failure):
                        XCTFail("User create failed with error \(failure)")
                    }
                }
            case .failure(let failure):
                XCTFail("Sign Up failed with error \(failure)")
            }
        }
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testFetchUsers() {
        let dbConfig = Firestore.firestore()
        dbConfig.useEmulator(withHost: "127.0.0.1", port: 8080)
        dbConfig.settings.cacheSettings = MemoryCacheSettings()
        dbConfig.settings.isSSLEnabled = false
        let db = FirebaseFirestore(dbConfig)
        let expectation = expectation(description: "Success fetch users")
        
        db.fetchUsers { results in
            switch results {
            case .success(let success):
                Swift.print(success)
                XCTAssertNotNil(success)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Failed to fetch users with error: \(failure)")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchUser() {
        let authConfig: Auth = Auth.auth()
        authConfig.useEmulator(withHost: "127.0.0.1", port: 9099)
        let auth = FirebaseAuth(authConfig)
        
        let dbConfig = Firestore.firestore()
        dbConfig.useEmulator(withHost: "127.0.0.1", port: 8080)
        dbConfig.settings.cacheSettings = MemoryCacheSettings()
        dbConfig.settings.isSSLEnabled = false
        let db = FirebaseFirestore(dbConfig)
        let expectation = expectation(description: "Success fetch user")
        
        auth.signInUsingEmail(email: "example@test.com", password: "12345678") { results in
            switch results {
            case .success(let success):
                db.fetchUser(success.user) { results in
                    switch results {
                    case .success(let success):
                        Swift.print(success)
                        XCTAssertNotNil(success)
                        expectation.fulfill()
                    case .failure(let failure):
                        XCTFail("Failed to fetch users with error: \(failure)")
                    }
                }
            case .failure(let failure):
                XCTFail("Sign In failed with error: \(failure)")
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testUpdateUser() {
        let authConfig: Auth = Auth.auth()
        authConfig.useEmulator(withHost: "127.0.0.1", port: 9099)
        let auth = FirebaseAuth(authConfig)
        
        let dbConfig = Firestore.firestore()
        dbConfig.useEmulator(withHost: "127.0.0.1", port: 8080)
        dbConfig.settings.cacheSettings = MemoryCacheSettings()
        dbConfig.settings.isSSLEnabled = false
        let db = FirebaseFirestore(dbConfig)
        let expectation = expectation(description: "Success fetch user")
        
        auth.signInUsingEmail(email: "example@test.com", password: "12345678") { results in
            switch results {
            case .success(let authResult):
                let userModel = UserModel(name: "updated Name")
                auth.updateUserProfile(userModel, authResult.user) { results in
                    switch results {
                    case .success(let success):
                        auth.getCurrentUser { results in
                            switch results {
                            case .success(let currentUser):
                                db.updateUser(currentUser) { results in
                                    switch results {
                                    case .success(let success):
                                        XCTAssertTrue(success)
                                        expectation.fulfill()
                                    case .failure(let failure):
                                        XCTFail("Update User in db failed with error: \(failure)")
                                    }
                                }
                            case .failure(let failure):
                                XCTFail("Get current user failed with error: \(failure)")
                            }
                        }
                    case .failure(let failure):
                        XCTFail("Update user in auth failed with error: \(failure)")
                    }
                }
            case .failure(let failure):
                XCTFail("Sign In failed with error: \(failure)")
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
        
    }
}

