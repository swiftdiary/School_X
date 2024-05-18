//
//  SubjectsView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct SubjectsView: View {
    var body: some View {
        VStack {
            List(0..<100) { x in
                HStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color.accentColor.gradient)
                        .frame(width: 80, height: 80)
                    VStack(alignment: .leading) {
                        Text("Subject Name")
                            .font(.title2.bold())
                        Text("Subtitle text (Optional)")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Subjects")
    }
}

#Preview {
    NavigationStack {
        SubjectsView()
    }
}
