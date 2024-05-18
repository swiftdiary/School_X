//
//  AuthView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct AuthView: View {
    @AppStorage("is_authenticated") private var isAuthenticated: Bool = false
    @AppStorage("authentication_token") private var authenticationToken: String = ""
    @State private var authVM = AuthViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                TextField("Name", text: $authVM.inputName)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.ultraThinMaterial)
                    }
                    .padding()
                Button("Sign Up!") {
                    Task {
                        do {
                            try await authVM.signIn()
                        } catch {
                            print(error)
                        }
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .font(.headline)
            }
            
        }
        .background {
            Rectangle()
                .fill(Color.accentColor.opacity(0.5).gradient)
                .ignoresSafeArea()
        }
        .onChange(of: authVM.signInToken) { oldValue, newValue in
            if oldValue.isEmpty, !newValue.isEmpty {
                authenticationToken = newValue
            }
        }
        .onChange(of: authVM.hasSignedIn) { oldValue, newValue in
            if oldValue == false, newValue == true {
                isAuthenticated = true
            }
        }
    }
}

#Preview {
    AuthView()
}
