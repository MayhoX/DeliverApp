//
//  FaceIDModel.swift
//  DeliverApp
//
//  Created by Evan Wong on 17/1/2024.
//

import Foundation
import LocalAuthentication

@MainActor
class FaceIDModel : ObservableObject {
    let context = LAContext()
    
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var isAuthenicated = false

    func checkPolicy(){
        var error : NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            self.isError = false
        } else {
            if let err = error {
                self.isError = true
                switch err.code {
                    case LAError.Code.biometryNotEnrolled.rawValue: self.errorMessage = "Not Enrolled"
                    case LAError.Code.passcodeNotSet.rawValue: self.errorMessage = "Passcode Not Set"
                    case LAError.Code.biometryNotAvailable.rawValue: self.errorMessage = "Not Available"
                default:
                    self.errorMessage = "Unkown Error"
                }
            }
        }
    }
    
    func evaluatePolicy(){
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authentication is reqired", reply: {
            success, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.isError = true
                    self.errorMessage = "Cannot login"
                    self.isAuthenicated = false
                } else {
                    self.isError = false
                    self.isAuthenicated = true

                }
            }
        })
    }
    

}

