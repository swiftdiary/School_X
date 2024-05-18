//
//  OnboardingView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") private var onboarding: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.accentColor.gradient)
                .ignoresSafeArea()
        }
    }
    
    
}

#Preview {
    OnboardingView()
}
