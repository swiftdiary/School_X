//
//  ContentView.swift
//  SchoolXTest
//
//  Created by Muhammadjon Madaminov on 18/05/24.
//

import SwiftUI
import SplineRuntime

struct SplinePasteView: View {
    let url: String
    let backgroundColor: Color
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    @State private var isLoading = true

    var body: some View {
        VStack {
            if let url = URL(string: url) {
                ZStack {
                    
                    if isLoading {
                        ProgressView()
                            .tint(Color.white)
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(backgroundColor)
                    }
                    
                    
                    try? SplineView(sceneFileURL: url)
                        .ignoresSafeArea(.all)
                }
            } else {
                Text("Invalid URL")
            }
        }
        .frame(width: frameWidth, height: frameHeight)
        .onAppear {
            loadSplineModel(from: url)
        }
    }
    
    private func loadSplineModel(from urlString: String) {
        DispatchQueue.global().async {
            guard URL(string: urlString) != nil else { return }
            sleep(30)
            DispatchQueue.main.async {
                isLoading = false
            }
        }
    }
}




#Preview {
    SplinePasteView(url: "https://build.spline.design/gYBCELFbfDN6KgnoHX0w/scene.splineswift", backgroundColor: .black.opacity(0.9), frameWidth: 400, frameHeight: 300)
//    SplinePasteView(url: "https://build.spline.design/orI-9TNImtOIuafILfoU/scene.splineswift", backgroundColor: .black.opacity(0.9))
}
