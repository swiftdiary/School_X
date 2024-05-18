//
//  OnboardingView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") private var onboarding: Bool = false
    @StateObject private var onboardingVM = OnboardingViewModel()
    
    var body: some View {
        let onboardItem = onboardingVM.onboardItems[onboardingVM.onboardIndex]
        NavigationStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.accentColor.gradient)
                    .ignoresSafeArea()
                
                VStack {
                    Image(systemName: "globe")
                        .font(.largeTitle)
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        Text(onboardItem.title)
                            .font(.largeTitle.bold())
                        Text(onboardItem.description)
                            .font(.headline)
                        HStack {
                            Spacer()
                            Button("Next >") {
                                withAnimation(.bouncy) {
                                    onboardingVM.next()
                                }
                            }
                            .buttonStyle(BorderedProminentButtonStyle())
                            .font(.headline)
                        }
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.thinMaterial)
                            .ignoresSafeArea()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Skip") {
                        onboarding = true
                    }
                    .foregroundStyle(.white)
                    .font(.headline)
                }
            }
        }
        .onChange(of: onboardingVM.onboardingEnded) { oldValue, newValue in
            if oldValue == false, newValue == true {
                onboarding = true
            }
        }
    }
    
    
}

#Preview {
    OnboardingView()
}
