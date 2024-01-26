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

    @MainActor func testSignIn() async throws {   //SignIn
        let authViewModel = AuthViewModel()
        var result = try await authViewModel.signIn(email: "test@gmail.com", password: "123456")
        XCTAssertNotNil(authViewModel.userSession)
        XCTAssertTrue(authViewModel.login)
        XCTAssertEqual(authViewModel.loginMethod, .emailAndPassword)
        
    }

    @MainActor func testSignUp() async throws {   //SignUp
        let authViewModel = AuthViewModel()
        var result = try await authViewModel.signUp(email: "test1@gmail.com", password: "123456", firstName: "FN", lastName: "LN")
        XCTAssertNotNil(authViewModel.userSession, "User session should not be nil after sign up.")
        XCTAssertEqual(authViewModel.loginMethod, .emailAndPassword, "Login method should be set to emailAndPassword.")
    }

    
    func testAddShop() async throws {   //Show View Test add shop
        let showViewModel = ShopViewModel()
        do {
            var result = try await showViewModel.AddShop(name: "test shop", latitude: "123.456", longitude: "789.012", address: "Test Address", image: Data())
        } catch {
            XCTFail("Adding shop failed with error: \(error.localizedDescription)")
        }
    }
    

    func testAddSItem() async throws {
        let sitemViewModel = SItemViewModel()
        do {
            var result = try await sitemViewModel.AddSItem(name: "test sitem", description: "test description", price: "123", image: Data(), shopID: "123456", type: "test type")
        } catch {
            XCTFail("Adding item failed with error: \(error.localizedDescription)")
        }
    }
    

}
