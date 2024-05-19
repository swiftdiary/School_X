//
//  CustomARView.swift
//  School_X
//
//  Created by Akbar Khusanbaev on 19/05/24.
//

import Foundation
import ARKit
import Combine
import SwiftUI
import RealityKit

class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        
        subscribeToActionStream()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .placeBlock(let url):
                    print("Sinkied: placeblock()")
                    self?.placeBlock(url: url)
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
//    func configurationExamples() {
//        let configuration = ARWorldTrackingConfiguration()
//        session.run(configuration)
//    }
//    
//    func anchorExamples() {
//        
//        let coordinateAnchor = AnchorEntity(world: .zero)
//        
//        scene.addAnchor(coordinateAnchor)
//    }
//    
//    func entityExamples() {
//
//        let sphere = MeshResource.generateSphere(radius: 1)
//        let entity = ModelEntity(mesh: sphere)
//        
//        let anchor = AnchorEntity()
//        anchor.addChild(entity)
//    }
    
    func placeBlock(url: URL) {
        // LOAD
        guard let modelEntity = try? Entity.loadModel(contentsOf: url) else {
            print("Failed to load model entity")
            return
        }
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        // Example: Place the model in the scene
        let anchor = AnchorEntity(plane: .any)
        anchor.addChild(modelEntity)
        scene.addAnchor(anchor)
        
    }
}
