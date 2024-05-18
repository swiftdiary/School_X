//
//  Tips.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 18/05/24.
//

import SwiftUI

struct Tips: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tips")
                .font(.largeTitle.bold())
            Text("A very big paragraph about the History of Uzbekistan")
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    
    Tips()
}
