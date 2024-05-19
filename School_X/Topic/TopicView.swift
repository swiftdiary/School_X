//
//  TopicView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import SwiftUI

struct TopicView: View {
    let subject: Subject
    @State private var topicVM = TopicViewModel()
    
    var body: some View {
        VStack {
            List(topicVM.topics) { topic in
                NavigationLink(value: NavigationOption.content(topic)) {
                    HStack {
                        if let photoWebp = topic.photoWebp {
                            VStack {
                                AsyncImage(url: URL(string: photoWebp)) { img in
                                    img.resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                                } placeholder: {
                                    ProgressView()
                                }
                                Spacer()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("\(topic.title)")
                                .font(.title3.bold())
                            HStack {
                                ForEach(0..<5) { _ in
                                    Image(systemName: "star.fill")
                                }
                                Text("5.0")
                            }
                            .font(.headline)
                            .foregroundStyle(.yellow)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Topics")
        .onAppear(perform: {
            Task.detached {
                do {
                    try await topicVM.getTopics(subject: subject.id)
                } catch {
                    print(error)
                }
            }
        })
    }
}

//#Preview {
////    TopicView(subject: )
//}
