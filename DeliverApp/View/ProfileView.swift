//
//  ProfileView.swift
//  DeliverApp
//
//  Created by Evan Wong on 14/1/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingLogoutAlert = false
    
    var body: some View {
        if let user = viewModel.currentUser{
            List {
                Section {
                    HStack{
                        Text(user.shortName)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.fullName)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(Color.secondary)
                        }
                    }
                }
                
                Section("Account") {
                    NavigationLink(destination: Text("Destination")) {
                        Text("Edit Profile")
                    }
                    
                    NavigationLink(destination: Text("Destination")) {
                        Text("Change Password")
                    }
                    
                    Button {
                        showingLogoutAlert.toggle()
                    } label: {
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showingLogoutAlert) {
                        Alert(
                            title: Text("Logout"),
                            message: Text("Are you sure you want to logout?"),
                            primaryButton: .destructive(
                                Text("Yes"),
                                action: {
                                    viewModel.signOut()
                                }
                            ),
                            secondaryButton: .cancel(Text("No"))
                        )
                    }
                }
            }
        }
    }
}



#Preview {
    ProfileView()
}
