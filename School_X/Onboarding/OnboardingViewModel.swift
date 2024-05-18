//
//  OnboardingViewModel.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import Foundation
import Observation

@Observable
final class OnboardingViewModel {
    var onboardIndex: Int = 0
    var onboardingEnded: Bool = false
    
    // local data
    let onboardItems: [OnboardItem] = [
        OnboardItem(title: "Title", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", backgroundImage: nil, background3DUrl: nil),
        OnboardItem(title: "Title2", description: "2Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", backgroundImage: nil, background3DUrl: nil),
        OnboardItem(title: "Title3", description: "3Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", backgroundImage: nil, background3DUrl: nil)
    ]
    
    @MainActor
    func next() {
        if onboardItems.count > onboardIndex + 1 {
            onboardIndex += 1
        } else {
            onboardingEnded = true
        }
    }
}

struct OnboardItem: Identifiable {
    let id: UUID = UUID()
    let title: String
    let description: String
    let backgroundImage: String?
    let background3DUrl: String?
}
