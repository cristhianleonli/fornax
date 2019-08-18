//
//  WorldViewCell.swift
//  Fornax
//
//  Created by Cristhian León on 7/30/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class WorldViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "worldViewCell"
    
    private let multiplier: CGFloat = 0.5
    
    private let imageView = UIImageView()
    
    private let planetLabel = UILabel()
    
    private let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainer()
        addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContainer() {
        container.backgroundColor = .clear
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
    
    private func addLabel() {
        addSubview(planetLabel)
        planetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        planetLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        planetLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        planetLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        planetLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        planetLabel.textAlignment = .center
        planetLabel.font = Fonts.worldLabel
        planetLabel.textColor = Colors.worldLabel
        planetLabel.text = Strings.loading
        
        container.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: planetLabel.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    }
    
    var world: World! {
        didSet {
            planetLabel.text = world.name
            imageView.image = world.image
        }
    }
}
