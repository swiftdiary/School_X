//
//  ContentView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppNavigation.self) private var navigation
    
    var body: some View {
        @Bindable var navigation = navigation
        
        TabView(selection: $navigation.tabSelection, content: {
            ForEach(TabBarOption.allCases, id: \.rawValue) { option in
                NavigationStack(path: $navigation.navigationPath) {
                    option.view
                        .navigationDestination(for: NavigationOption.self) { option in
                            option.destination
                        }
                }
                .tag(option)
                .tabItem { option.label }
            }
        })
    }
}

#Preview {
    ContentView()
}
