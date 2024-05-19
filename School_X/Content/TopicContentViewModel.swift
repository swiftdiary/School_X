//
//  TopicContentViewModel.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation
import Observation

@Observable
final class TopicContentViewModel {
    var topicContents = [Content]()
    
    @ObservationIgnored private let apiManager = APIManager()
    
    func getContents(topic: Int) async throws {
        guard let url = URL(string: APIRequestUrl.contents.urlString) else {
            return
        }
        
        let response: GetResponseTemplate<Content> = try await apiManager.get(url: url, queryParams: ["topic" : "\(topic)"])
        
        await MainActor.run {
            topicContents = response.results
        }
    }
}
