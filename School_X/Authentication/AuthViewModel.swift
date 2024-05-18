//
//  AuthViewModel.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI
import Observation

@Observable
final class AuthViewModel {
    var hasSignedIn: Bool = false
    var signInToken: String = ""
    var inputName: String = ""
    
    func signIn() async throws {
        // Token should be received from web
        
        // After successfull signIn hasSignedIn must become true
        await MainActor.run {
            hasSignedIn = true
        }
    }
}
