//
//  AuthView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct AuthView: View {
    @AppStorage("is_authenticated") private var isAuthenticated: Bool = false
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
                    print("Sign Up!")
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
    }
}

#Preview {
    AuthView()
}
