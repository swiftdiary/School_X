//
//  School_XApp.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

@main
struct School_XApp: App {
    @AppStorage("onboarding") private var onboarding: Bool = false
    @State private var navigation = AppNavigation()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if !onboarding {
                    OnboardingView()
                } else {
                    ContentView()
                        .environment(navigation)
                }
            }
            .task {
                
            }
        }
    }
}
