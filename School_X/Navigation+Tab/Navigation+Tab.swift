//
//  Navigation+Tab.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI
import Observation

@Observable
final class AppNavigation {
    var navigationPath: [NavigationOption] = []
    var tabSelection: TabBarOption = .today
    
    func go(to screen: NavigationOption) {
        navigationPath.append(screen)
    }
    
    func back() {
        _ = navigationPath.popLast()
    }
}

enum NavigationOption: Hashable {
    case tips
    case topics(Subject) // subject
    case content(Topic) // topic
    case contentStarted([Content])
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .tips: Tips()
        case .topics(let subject): TopicView(subject: subject)
        case .content(let topic): TopicContentView(topic: topic)
        case .contentStarted(let contents): TopicContentStartedView(contents: contents)
        }
    }
}

enum TabBarOption: String, Hashable, CaseIterable {
    case today
    case subjects
    case search
    case stats
    case profile
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .today:
            TodayView()
        case .subjects: 
            SubjectsView()
        case .search:
            SearchView()
        case .stats: 
            StatsView()
        case .profile:
            ProfileView()
        }
    }
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .today:
            Label("Today", systemImage: "doc.text.image")
        case .subjects:
            Label("Subjects", systemImage: "book.fill")
        case .search:
            Label("Search", systemImage: "magnifyingglass")
        case .stats:
            Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
        case .profile:
            Label("Profile", systemImage: "person.crop.circle.fill")
        }
    }
    
}
