//
//  ApplePayView.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import SwiftUI
import PassKit

//struct ApplePayView: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIViewController {
//        let viewController = UIViewController()
//        let paymentButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
//        paymentButton.addTarget(context.coordinator, action: #selector(context.coordinator.handleApplePayButtonPress), for: .touchUpInside)
//        viewController.view.addSubview(paymentButton)
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Coordinator: NSObject, PKPaymentAuthorizationViewControllerDelegate {
//        func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
//            // Implement this method to handle the completion of the Apple Pay authorization process
//            // This method is called when the user finishes the payment process or cancels it
//            controller.dismiss(animated: true, completion: nil)
//        }
//
//        func paymentAuthorizationViewController(
//            _ controller: PKPaymentAuthorizationViewController,
//            didAuthorizePayment payment: PKPayment,
//            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
//        ) {
//            // Implement this method to handle the authorization of the payment
//            // Perform necessary tasks, such as sending payment details to your server for processing
//            // You'll need to call the completion handler with the appropriate result (success or failure)
//            // For simplicity, let's assume the payment is successful
//            let paymentAuthorizationResult = PKPaymentAuthorizationResult(status: .success, errors: nil)
//            completion(paymentAuthorizationResult)
//        }
//
//        // Additional delegate methods can be implemented as needed, such as for shipping method selection, etc.
//    }
//
//}


//#Preview {
//    ApplePayView()
//}
