//
//  AuthViewModel.swift
//  DeliverApp
//
//  Created by Evan Wong on 14/1/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAnalytics


protocol AuthProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var login: Bool
    @Published var loginMethod: LoginMethod = .none
    var faceIDModel: FaceIDModel?
    
    
    init(){
        self.userSession = Auth.auth().currentUser
        self.login = false
        
        Task {
            await fetchUser()
        }
    }
    
    func setFaceIDModel(_ faceIDModel: FaceIDModel) {
        self.faceIDModel = faceIDModel
    }
    
    
    func signIn(email: String, password: String) async throws {    //signIn
        
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
        self.login = true           //set login to true
        self.loginMethod = .emailAndPassword
        await fetchUser()
        
    }
    
    
    func signUp(email: String, password: String, firstName: String, lastName: String) async throws {  //signuUp
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, email: email, state: "user")
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
            self.loginMethod = .emailAndPassword
        } catch {
            print("ERROR SIGN UP \(error.localizedDescription)")
        }
    }
    
    
    func signOut() async throws{
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            self.login = false
            self.loginMethod = .none
            try await faceIDModel?.isAuthenicated = false
        } catch {
            print("ERROR SIGN OUT \(error.localizedDescription)")
        }
    }


    
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
        } catch {
            print("ERROR GETTING USER DOC \(error.localizedDescription)")
        }
    }
    

    enum LoginMethod {
        case none
        case emailAndPassword
        case faceID
    }
    
    
}
