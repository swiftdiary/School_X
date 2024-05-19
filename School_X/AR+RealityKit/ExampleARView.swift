//
//  ExampleARView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import SwiftUI

struct ExampleARView: View {
    @State private var exampleARVM = ExampleARViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARScreen()
            HStack {
                ForEach(exampleARVM.contents) { content in
                    Button("\(content.title ?? "Untitled object")") {
                        Task {
                            do {
                                if let threeDFile = content.threeDFile, let url = URL(string:threeDFile) {
                                    try await exampleARVM.download3D(url: url)
                                }
                            } catch {
                                print("error, \(error)")
                            }
                        }
                    }
                }
                Button(action: {
                    ARManager.shared.actionStream.send(.removeAllAnchors)
                }, label: {
                    Text("Delete All")
                })
            }
            .frame(height: 100)
            .background(Color.white)
        }
        .onAppear(perform: {
            Task {
                do {
                    try await exampleARVM.getContents()
                } catch {
                    print(error)
                }
            }
        })
        .onChange(of: exampleARVM.downloadedUrl) { oldValue, newValue in
            if let newValue {
                print("New Value: \(newValue)")
                ARManager.shared.actionStream.send(.placeBlock(newValue))
            }
        }
    }
}

#Preview {
    ExampleARView()
}
