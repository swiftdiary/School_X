//
//  SubjectsViewModel.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation
import Observation

@Observable
final class SubjectsViewModel {
    var subjects = [Subject]()
    
    @ObservationIgnored private var apiManager = APIManager()
    
    func getSubjects() async throws {
        guard let url = URL(string: APIRequestUrl.subjects.urlString) else { throw SubjectsViewModelError.wrongURL }
        let response: GetResponseTemplate<Subject> = try await apiManager.get(url: url)
        print(response)
        if !response.results.isEmpty {
            await MainActor.run {
                subjects = response.results
            }
        }
    }
    
}

enum SubjectsViewModelError: Error {
    case wrongURL
}
