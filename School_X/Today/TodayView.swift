//
//  TodayView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct TodayView: View {
    @Environment(AppNavigation.self) private var navigation
    
    var body: some View {
        VStack {
            Text("Hello, Today!")
            Button("Go") {
                navigation.go(to: .tips)
            }
        }
    }
}

#Preview {
    TodayView()
}
