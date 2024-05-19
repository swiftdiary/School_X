//
//  TopicViewModel.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation
import Observation

@Observable
final class TopicViewModel {
    var topics = [Topic]()
    
    @ObservationIgnored private let apiManager = APIManager()
    
    func getTopics(subject: Int) async throws {
        guard let url = URL(string: APIRequestUrl.topics.urlString) else {
            return
        }
        
        let response: GetResponseTemplate<Topic> = try await apiManager.get(url: url, queryParams: ["subject" : "\(subject)"])
        
        await MainActor.run {
            topics = response.results
        }
    }
    
}
