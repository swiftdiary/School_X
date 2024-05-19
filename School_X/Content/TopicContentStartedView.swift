//
//  TopicContentStartedView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import SwiftUI

struct TopicContentStartedView: View {
    let contents: [Content]
    
    var body: some View {
        VStack {
            Text("Hello \(contents.count)")
        }
    }
}

#Preview {
    TopicContentStartedView(contents: [])
}
