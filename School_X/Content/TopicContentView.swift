//
//  TopicContentView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import SwiftUI

struct TopicContentView: View {
    let topic: Topic
    @State private var topicContentVM = TopicContentViewModel()
    @Environment(AppNavigation.self) private var navigation
    
    var body: some View {
        @Bindable var navigation = navigation
        VStack {
            ScrollView {
                if let topicPhoto = topic.photo, let url = URL(string: topicPhoto) {
                    AsyncImage(url: url) { img in
                        img.resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 200)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.orange.gradient)
                        .frame(height: 300)
                }
                Text("\(topic.description)")
                    .fontWeight(.semibold)
                    .padding()
                
                
                Button("Start") {
                    if !topicContentVM.topicContents.isEmpty {
                        navigation.go(to: .contentStarted(topicContentVM.topicContents))
                    } else {
                        print("No contents available")
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .font(.title3.bold())
            }
        }
        .navigationTitle("\(topic.title)")
        .onAppear(perform: {
            Task.detached {
                do {
                    try await topicContentVM.getContents(topic: topic.id)
                } catch {
                    print(error)
                }
            }
        })
    }
    
}

#Preview {
    TopicContentView(topic: Topic(id: 1, subject: 1, title: "2", description: "..", photo: "", photoWebp: "", updatedAt: "", createdAt: ""))
}
