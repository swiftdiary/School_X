//
//  ARScreen.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import SwiftUI

struct ARScreen: View {
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    ARScreen()
}
