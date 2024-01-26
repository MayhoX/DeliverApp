//
//  DeliverAppTests.swift
//  DeliverAppTests
//
//  Created by Evan Wong on 13/1/2024.
//

import XCTest
@testable import DeliverApp

final class DeliverAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func testSignIn() async throws {
        let authViewModel = AuthViewModel()
        var result = try await authViewModel.signIn(email: "test@gmail.com", password: "123456")
        XCTAssertNotNil(authViewModel.userSession)
        XCTAssertTrue(authViewModel.login)
        XCTAssertEqual(authViewModel.loginMethod, .emailAndPassword)
        
    }

    @MainActor func testSignUp() async throws {
        let authViewModel = AuthViewModel()
        var result = try await authViewModel.signUp(email: "test1@gmail.com", password: "123456", firstName: "FN", lastName: "LN")
        XCTAssertNotNil(authViewModel.userSession, "User session should not be nil after sign up.")
        XCTAssertEqual(authViewModel.loginMethod, .emailAndPassword, "Login method should be set to emailAndPassword.")
    }


}
