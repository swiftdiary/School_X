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
        @Bindable var navigation = navigation
        VStack {
            ScrollView {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(Color.orange.gradient)
                
                    .stroke(.white.opacity(0.5),lineWidth: 3)
                    .frame(height: 200)
                    .overlay(content: {
                        HStack {
                            Text("Tips")
                            Image(systemName: "lightbulb.min.fill")
                        }
                        .font(.largeTitle.bold())
                        .foregroundStyle(.background)
                    })
                    .padding()
                VStack(alignment: .leading) {
                    Text("Top")
                        .font(.title.bold())
                    Rectangle()
                        .frame(height: 2)
                }
                .padding()
            }
        }
    }
}

#Preview {
    @State var navigation = AppNavigation()
    
    return TodayView()
        .environment(navigation)
}
