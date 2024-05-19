//
//  SubjectsView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct SubjectsView: View {
    @State private var subjectsVM = SubjectsViewModel()
    
    var body: some View {
        VStack {
            List(subjectsVM.subjects) { subject in
                NavigationLink(value: NavigationOption.topics(subject)) {
                    HStack {
                        AsyncImage(url: URL(string: subject.photoWebp)) { img in
                            img
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(Color.accentColor.gradient)
                                .frame(width: 80, height: 80)
                                .overlay {
                                    ProgressView()
                                }
                        }

                        VStack(alignment: .leading) {
                            Text(subject.title)
                                .font(.title2.bold())
                            Text("Subtitle text (Optional)")
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Subjects")
        .onAppear(perform: {
            Task.detached {
                do {
                    try await subjectsVM.getSubjects()
                } catch {
                    print("Error", error)
                }
            }
        })
    }
}

#Preview {
    NavigationStack {
        SubjectsView()
    }
}
