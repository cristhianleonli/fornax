//
//  DashboardViewCell.swift
//  Fornax
//
//  Created by Cristhian León on 8/1/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MainViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "mainViewCell"
    
    private let titleImage = UIImageView(image: Images.title)
    
    private var timeouts = [Timeout]()
    
    private let tapContainer = UIView()
    
    private weak var delegate: ParentViewDelegate?
    
    private lazy var tapButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.tapToPlay, for: .normal)
        button.titleLabel?.font = Fonts.mainLabel
        button.setTitleColor(Colors.mainLabel, for: .normal)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = Fonts.mainLabel
        button.setTitle(Strings.settingButton, for: .normal)
        button.setTitleColor(Colors.mainLabel, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTitle()
        addTapText()
        addSettingsView()
        startLabelAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSettingsView() {
        let container = UIView()
        addSubview(container)
        
        // container
        container.translatesAutoresizingMaskIntoConstraints = false
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        container.leadingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        container.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // gear
        let image = UIImageView(image: Images.gear)
        image.contentMode = .scaleAspectFit
        container.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        image.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showSettingsTab))
        image.addGestureRecognizer(tapGesture)
        
        // settings label
        container.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -8).isActive = true
        settingsButton.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        settingsButton.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        settingsButton.addTarget(self, action: #selector(showSettingsTab), for: .touchUpInside)
    }
    
    private func addTapText() {
        addSubview(tapContainer)
        tapContainer.translatesAutoresizingMaskIntoConstraints = false
        
        tapContainer.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 40).isActive = true
        tapContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        tapContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        tapContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        tapContainer.addSubview(tapButton)
        tapButton.translatesAutoresizingMaskIntoConstraints = false
        
        tapButton.centerXAnchor.constraint(equalTo: tapContainer.centerXAnchor).isActive = true
        tapButton.centerYAnchor.constraint(equalTo: tapContainer.centerYAnchor).isActive = true
        
        tapButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        
        // tap gesture on tapContainer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startGame))
        tapContainer.addGestureRecognizer(tapGesture)
    }
    
    private func addTitle() {
        titleImage.contentMode = .scaleAspectFit
        
        addSubview(titleImage)
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        titleImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func showSettingsTab() {
        self.delegate?.showSettingsTab()
    }
    
    @objc func startGame() {
        self.delegate?.startGame()
    }
    
    private func startLabelAnimation() {
        timeouts.append(Timeout(delaySeconds: 5, immediately: true) {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseIn], animations: {[weak self] in
                self?.tapButton.alpha = 0
                }, completion: { finished in
                    UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut], animations: {[weak self] in
                        self?.tapButton.alpha = 1
                        }, completion: nil)
            })
        })
    }
    
    func setScroll(value: CGFloat) {
        let maxWidth = frame.width * 0.6
        let percentage = 1 - (value / maxWidth)
        alpha = percentage
    }
    
    func setDelegate(_ delegate: ParentViewDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        for timeout in timeouts {
            timeout.cancel()
        }
    }
}
