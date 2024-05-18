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
    
    @ObservationIgnored let apiManager = APIManager()
    
    func signIn() async throws {
        // Token should be received from web
        guard let url = URL(string: APIRequestUrl.auth.urlString) else { throw AuthViewModelError.wrongURLError }
        let requestBody: [String: String] = [
            "name" : inputName
        ]
        
        let response: AuthResponseType = try await apiManager.post(url: url, body: requestBody)

        await MainActor.run {
            signInToken = response.access
        }
        try await Task.sleep(nanoseconds: 100_000)
        // After successfull signIn hasSignedIn must become true
        await MainActor.run {
            hasSignedIn = true
        }
    }
}

enum AuthViewModelError: Error {
    case wrongURLError
}
