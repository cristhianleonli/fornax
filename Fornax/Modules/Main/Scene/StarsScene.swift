//
//  StarsScene.swift
//  Fornax
//
//  Created by Cristhian León on 8/3/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit
import GameKit

class StarsScene: SKScene {
    
    private let particleSize = CGSize(width: 10, height: 10)
    
    override func didMove(to view: SKView) {
        addElements()
    }
    
    private func addElements() {
        backgroundColor = .clear
        addStarsParticle()
    }
    
    private func addStarsParticle() {
        guard let emitterNode = SKEmitterNode(fileNamed: "StarsMagicParticles") else { return }
        emitterNode.position = CGPoint(x: 0, y: 0)
        emitterNode.particleSize = particleSize
        emitterNode.speed = 0.1
        addChild(emitterNode)
    }
}
