//
//  ProfileView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var profileVM = ProfileViewModel()
    
    var body: some View {
        VStack {
            if let userData = profileVM.userData {
                List {
                    HStack {
                        Text("Name: ")
                        Text(userData.firstName)
                            .font(.headline)
                    }
                    HStack {
                        Text("Coins: ")
                        Text("\(userData.coin)")
                            .font(.headline)
                    }
                    HStack {
                        Text("ID: ")
                        Text("\(userData.id)")
                            .font(.headline)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: {
            Task {
                do {
                    try await profileVM.getUser()
                } catch {
                    print(error)
                }
            }
        })
    }
}

#Preview {
    ProfileView()
}
