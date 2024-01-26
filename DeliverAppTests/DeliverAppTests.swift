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
            try await showViewModel.AddShop(name: "test shop", latitude: "123.456", longitude: "789.012", address: "Test Address", image: Data())
        } catch {
            XCTFail("Adding shop failed with error: \(error.localizedDescription)")
        }
    }
    

    func testAddSItem() async throws {
        let sitemViewModel = SItemViewModel()
        do {
            try await sitemViewModel.AddSItem(name: "test sitem", description: "test description", price: "123", image: Data(), shopID: "123456", type: "test type")
        } catch {
            XCTFail("Adding item failed with error: \(error.localizedDescription)")
        }
    }
    
    func testAddToCart()  throws {
        let shoppingCartViewModel = ShoppingCartViewModel()
        let sitem = SItem(id: "123", name: "Test Item", description: "Test Description", price: "19.99", image: Data(), type: "Test Type")
        let quantity = 2
        
        do {
            shoppingCartViewModel.addToCart(sitem: sitem, quantity: quantity)
        } catch {
            XCTFail("Adding to cart failed with error: \(error.localizedDescription)")
        }
    }

        func testRemoveFromCart() throws {
            let shoppingCartViewModel = ShoppingCartViewModel()
            let cartItem = ShoppingCartItem(id: "456", sitem: SItem(id: "789", name: "Test Item", description: "Test Description", price: "19.99", image: Data(), type: "Test Type"), quantity: 3)

            do {
                shoppingCartViewModel.removeFromCart(cartItem: cartItem)
            } catch {
                XCTFail("Remove to cart failed with error: \(error.localizedDescription)")
            }
        }

        func testUpdateQuantity() throws {
            let shoppingCartViewModel = ShoppingCartViewModel()
            let cartItem = ShoppingCartItem(id: "789", sitem: SItem(id: "123", name: "Test Item", description: "Test Description", price: "19.99", image: Data(), type: "Test Type"), quantity: 3)
            
            do {
                shoppingCartViewModel.updateQuantity(cartItem: cartItem, quantity: 5)
            } catch {
                XCTFail("Update quantity failed with error: \(error.localizedDescription)")
            }
        }

        func testClearAll() throws {
            let shoppingCartViewModel = ShoppingCartViewModel()

            do {
                shoppingCartViewModel.clearAll()
            } catch {
                XCTFail("Clearing all items failed with error: \(error.localizedDescription)")
            }
        }
    

}
