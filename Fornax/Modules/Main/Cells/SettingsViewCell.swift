//
//  SettingsCell.swift
//  Fornax
//
//  Created by Cristhian León on 8/2/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit

class SettingsViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "settingsViewCell"
    
    private weak var delegate: ParentViewDelegate?
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = Fonts.mainLabel
        button.setTitle(Strings.backButton, for: .normal)
        button.setTitleColor(Colors.mainLabel, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBackButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(_ delegate: ParentViewDelegate) {
        self.delegate = delegate
    }
    
    private func addBackButton() {
        let container = UIView()
        addSubview(container)
        
        // container
        container.translatesAutoresizingMaskIntoConstraints = false
        container.trailingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        container.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // gear
        let image = UIImageView(image: Images.backIcon)
        image.contentMode = .scaleAspectFit
        container.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        image.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showMainTab))
        image.addGestureRecognizer(tapGesture)
        
        // settings label
        container.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5).isActive = true
        backButton.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        backButton.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        backButton.addTarget(self, action: #selector(showMainTab), for: .touchUpInside)
    }
    
    @objc func showMainTab() {
        self.delegate?.showMainTab()
    }
}
