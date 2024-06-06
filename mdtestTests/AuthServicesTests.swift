//
//  AuthServicesTests.swift
//  mdtestTests
//
//  Created by Rifqi Alhakim Hariyantoputera on 06/06/24.
//

import XCTest
import FirebaseCore
import FirebaseAuth
@testable import mdtest

final class AuthServicesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        FirebaseApp.configure()
    }
    
    func testSignUpUsingEmail() {
        let authConfig: Auth = Auth.auth()
        authConfig.useEmulator(withHost: "127.0.0.1", port: 9099)
        let auth = FirebaseAuth(authConfig)
        
        let expectation = expectation(description: "Sign Up successfully")
        
        auth.signUpUsingEmail(email: "example@test.com", password: "12345678") { results in
            switch results {
            case .success(let success):
                XCTAssertEqual(success.user.email, "example@test.com")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Sign Up failed with error: \(failure)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSignInUsingEmail() {
        let authConfig: Auth = Auth.auth()
        authConfig.useEmulator(withHost: "127.0.0.1", port: 9099)
        let auth = FirebaseAuth(authConfig)
        
        let expectation = expectation(description: "Sign In successfully")
        
        auth.signInUsingEmail(email: "example@test.com", password: "12345678") { results in
            switch results {
            case .success(let success):
                XCTAssertEqual(success.user.email, "example@test.com")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Sign In failed with error: \(failure)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSignOut() {
        let authConfig: Auth = Auth.auth()
        authConfig.useEmulator(withHost: "127.0.0.1", port: 9099)
        let auth = FirebaseAuth(authConfig)
        
        let expectation = expectation(description: "Sign out successfully")
        
        auth.signInUsingEmail(email: "example@test.com", password: "12345678") { results in
            switch results {
            case .success:
                break
            case .failure(let failure):
                XCTFail("Sign In failed with error: \(failure)")
            }
        }
        
        auth.signOut { results in
            switch results {
            case .success(let success):
                XCTAssertTrue(success)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Sign Out failed with error: \(failure)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testVerifyEmail() {
        let authConfig: Auth = Auth.auth()
        authConfig.useEmulator(withHost: "127.0.0.1", port: 9099)
        let auth = FirebaseAuth(authConfig)
        
        let expectation = expectation(description: "Verify email successfully")
        
        auth.signInUsingEmail(email: "example@test.com", password: "12345678") { results in
            switch results {
            case .success(let success):
                auth.verifyEmail(success.user) { results in
                    switch results {
                    case .success(let success):
                        XCTAssertTrue(success)
                        expectation.fulfill()
                    case .failure(let failure):
                        XCTFail("Verify Email failed with error: \(failure)")
                    }
                }
            case .failure(let failure):
                XCTFail("Sign In failed with error: \(failure)")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUpdateUserProfile() {
        let authConfig: Auth = Auth.auth()
        authConfig.useEmulator(withHost: "127.0.0.1", port: 9099)
        let auth = FirebaseAuth(authConfig)
        
        let expectation = expectation(description: "Update profile success")
        let userModel = UserModel(name: "New Name")
        
        auth.signInUsingEmail(email: "example@test.com", password: "12345678") { results in
            switch results {
            case .success(let success):
                auth.updateUserProfile(userModel, success.user) { results in
                    switch results {
                    case .success(let success):
                        XCTAssertTrue(success)
                        expectation.fulfill()
                    case .failure(let failure):
                        XCTFail("Update profile failed with error: \(failure)")
                    }
                }
            case .failure(let failure):
                XCTFail("Sign In failed with error: \(failure)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testResetPassword() {
        let authConfig: Auth = Auth.auth()
        authConfig.useEmulator(withHost: "127.0.0.1", port: 9099)
        let auth = FirebaseAuth(authConfig)
        
        let expectation = expectation(description: "Reset password success")
        
        auth.resetPassword(email: "example@test.com") { results in
            switch results {
            case .success(let success):
                XCTAssertTrue(success)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Reset password failed with error: \(failure)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
