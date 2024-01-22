//
//  PaymentView.swift
//  DeliverApp
//
//  Created by Evan Wong on 22/1/2024.
//

import SwiftUI

struct PaymentView: View {
    @State private var selectedPaymentMethod: String = "Credit Card"
    @State private var deliveryAddress: String = ""
    @State private var estimatedArrival: String = "2 Day"
    @State private var creditCardNumber: String = ""
    @State private var expirationDate: String = ""
    @State private var cvv: String = ""
    @State private var paymentSuccessAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var shoppingCartViewModel: ShoppingCartViewModel

    var body: some View {
        VStack {
            Picker("Payment Method", selection: $selectedPaymentMethod) {
                Text("Credit Card").tag("Credit Card")
                Text("Cash on Delivery").tag("Cash on Delivery")
                // Add other payment methods as needed
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedPaymentMethod == "Credit Card" {
                TextField("Credit Card Number", text: $creditCardNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            
                HStack {
                    TextField("Expiration Date", text: $expirationDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("CVV", text: $cvv)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                     
                }
                .padding(.horizontal)
            }
            
            TextField("Delivery Address", text: $deliveryAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 50)
                .padding()
            
            Text("Arrival: \(estimatedArrival)")
                .padding()
            
            
            Text("Total to Pay: \(shoppingCartViewModel.cart.total)")
                .font(.headline)
                .padding()
            
            
            Button(action: {
                paymentSuccessAlert = true
                shoppingCartViewModel.clearAll()
            }) {
                HStack {
                    Image(systemName: "applelogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("Pay")
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(8)
            }
            .alert(isPresented: $paymentSuccessAlert) {
                Alert(
                    title: Text("Payment Success"),
                    message: Text("Thank you for your payment."),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
            .padding()
            
            
        }
        .navigationTitle("Payment")
    }
}


