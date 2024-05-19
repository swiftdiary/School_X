//
//  ARKit.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation
import Combine
import SwiftUI

enum ARAction {
    case placeBlock(URL)
    case removeAllAnchors
}

final class ARManager {
    static let shared = ARManager()
    private init() { }
    
    var actionStream = PassthroughSubject<ARAction, Never>()
    
}

struct CustomARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) { }
}
