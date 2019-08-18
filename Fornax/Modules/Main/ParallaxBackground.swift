//
//  ParallaxBackground.swift
//  Fornax
//
//  Created by Cristhian León on 8/2/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class ParallaxBackground: UIView {
    
    private let star = ShootingStar()
    
    private let back = UIImageView(image: Images.Background.mainBackground)
    
    private let downMountains = UIImageView(image: Images.Background.downRocks)
    
    private let blackMountains = UIImageView(image: Images.Background.sideRocks)
    
    private let spaceRocks = UIImageView(image: Images.Background.spaceRocks)
    
    private let rock1 = UIImageView(image: Images.Background.rock1)
    
    private let rock2 = UIImageView(image: Images.Background.rock2)
    
    private let rockSize: CGFloat = 50
    
    private let rockRotationDuration: CFTimeInterval = 10
    
    private let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    
    // constraints
    
    private var downMountainsConstraint: NSLayoutConstraint?
    
    private var backgroundConstraint: NSLayoutConstraint?
    
    private var blackMountainsConstraint: NSLayoutConstraint?
    
    private var spaceRocksConstraint: NSLayoutConstraint?
    
    private var rock1Constraint: NSLayoutConstraint?
    
    private var rock2Constraint: NSLayoutConstraint?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addBackground()
        addStar()
        addParticles()
        addSpaceRocks()
        addDownMountains()
        addBlackMountains()
    }
    
    private func addParticles() {
        let sceneContainer = SKView()
        sceneContainer.backgroundColor = .clear
        addSubview(sceneContainer)
        sceneContainer.frame = frame
        
        let scene = StarsScene()
        scene.size = sceneContainer.frame.size
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .aspectFill
        sceneContainer.presentScene(scene)
    }
    
    private func addBackground() {
        addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.topAnchor.constraint(equalTo: topAnchor).isActive = true
        back.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        backgroundConstraint = back.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        backgroundConstraint?.isActive = true
        
        back.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2).isActive = true
    }
    
    private func addDownMountains() {
        addSubview(downMountains)
        downMountains.translatesAutoresizingMaskIntoConstraints = false
        downMountains.topAnchor.constraint(equalTo: topAnchor).isActive = true
        downMountains.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        downMountainsConstraint = downMountains.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        downMountainsConstraint?.isActive = true
        
        downMountains.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2).isActive = true
    }
    
    private func addBlackMountains() {
        addSubview(blackMountains)
        blackMountains.translatesAutoresizingMaskIntoConstraints = false
        blackMountains.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blackMountains.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        blackMountainsConstraint = blackMountains.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        blackMountainsConstraint?.isActive = true
        
        blackMountains.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2).isActive = true
    }
    
    private func addSpaceRocks() {
        addSubview(spaceRocks)
        
        spaceRocks.translatesAutoresizingMaskIntoConstraints = false
        spaceRocks.topAnchor.constraint(equalTo: topAnchor).isActive = true
        spaceRocks.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        spaceRocksConstraint = spaceRocks.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        spaceRocksConstraint?.isActive = true
        spaceRocks.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2).isActive = true
        
        addRocks()
    }
    
    private func addRocks() {
        addSubview(rock1)
        rock1.translatesAutoresizingMaskIntoConstraints = false
        rock1Constraint = rock1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        rock1Constraint?.isActive = true
        rock1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rock1.widthAnchor.constraint(equalToConstant: rockSize).isActive = true
        rock1.heightAnchor.constraint(equalToConstant: rockSize).isActive = true
        
        // second rock, on the right of the screen
        addSubview(rock2)
        rock2.translatesAutoresizingMaskIntoConstraints = false
        rock2Constraint = rock2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        rock2Constraint?.isActive = true
        rock2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        rock2.widthAnchor.constraint(equalToConstant: rockSize).isActive = true
        rock2.heightAnchor.constraint(equalToConstant: rockSize).isActive = true
        
        for rock in [rock1, rock2] {
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Double.pi * 2
            rotationAnimation.duration = rockRotationDuration
            rotationAnimation.repeatCount = .infinity
            rock.layer.add(rotationAnimation, forKey: nil)
        }
    }
    
    private func addStar() {
        star.add(in: self)
        star.startAnimation()
    }
    
    /**
     Should be called at every scroll movement
     - Parameter position: current position of the scroll
     */
    func didMove(to position: CGFloat) {
        if position > 0 {
            backgroundConstraint?.constant = -position/3
        }
        
        downMountainsConstraint?.constant = -position
        blackMountainsConstraint?.constant = -(position * 2)
        spaceRocksConstraint?.constant = -(position / 2)
        rock1Constraint?.constant = -(position / 2) + 30
        rock2Constraint?.constant = -(position / 2) - 50
    }
}
