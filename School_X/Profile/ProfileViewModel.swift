//
//  ProfileViewModel.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation
import Observation

@Observable
final class ProfileViewModel {
    var userData: Profile?
    
    @ObservationIgnored private let apiManager = APIManager()
    
    func getUser() async throws {
        guard let url = URL(string: APIRequestUrl.profile.urlString) else { return }
        
        let response: Profile = try await apiManager.get(url: url)
        
        await MainActor.run {
            userData = response
        }
    }
}
