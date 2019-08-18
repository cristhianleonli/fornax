
//
//  DashboardViewController.swift
//  Fornax
//
//  Created by Cristhian León on 7/30/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class DashboardViewController: UIViewController {
    
    private let viewModel = DashboardViewModel()
    private var collectionView: UICollectionView!
    private let back = UIImageView(image: Images.Background.mainBackground)
    private var backgroundConstraint: NSLayoutConstraint?
    private let contentInset = UIEdgeInsets.zero
    private let itemsPerRow: CGFloat = 3
    private lazy var itemSize = view.frame.height
    private let shootingStar = ShootingStar()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        addBackgroundLayer()
        addParallaxElements()
        addCollection()
        addLeftView()
        addRightView()
        addBottomView()
    }
    
    private func addLeftView() {
        let viewContainer = UIView()
        view.addSubview(viewContainer)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        viewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        viewContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        viewContainer.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        let homeButton = UIButton()
        homeButton.setImage(Images.homeIcon, for: .normal)
        viewContainer.addSubview(homeButton)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.widthAnchor.constraint(equalTo: viewContainer.heightAnchor).isActive = true
        homeButton.heightAnchor.constraint(equalTo: viewContainer.heightAnchor).isActive = true
        homeButton.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor).isActive = true
        homeButton.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        
        let label = UIButton()
        label.setTitle(Strings.home, for: .normal)
        label.titleLabel?.font = Fonts.coins
        label.setTitleColor(Colors.coins, for: .normal)
        label.contentHorizontalAlignment = .left
        
        viewContainer.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalTo: viewContainer.heightAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: homeButton.trailingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor).isActive = true
        
        [label, homeButton].forEach { button in
            button.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
        }
    }
    
    private func addRightView() {
        let viewContainer = UIView()
        view.addSubview(viewContainer)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        viewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        viewContainer.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        let label = UIButton()
        label.setTitle(Strings.coinsPlaceholder, for: .normal)
        label.titleLabel?.font = Fonts.coins
        label.setTitleColor(Colors.coins, for: .normal)
        label.contentHorizontalAlignment = .right
        
        viewContainer.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: viewContainer.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -5).isActive = true
        
        let coinButton = UIButton()
        coinButton.setImage(Images.coins, for: .normal)
        viewContainer.addSubview(coinButton)
        coinButton.translatesAutoresizingMaskIntoConstraints = false
        coinButton.widthAnchor.constraint(equalTo: viewContainer.heightAnchor).isActive = true
        coinButton.heightAnchor.constraint(equalTo: viewContainer.heightAnchor).isActive = true
        coinButton.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -5).isActive = true
        coinButton.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor).isActive = true
        
        [label, coinButton].forEach { button in
            button.addTarget(self, action: #selector(goToCoins), for: .touchUpInside)
        }
    }
    
    private func addBottomView() {
        let storeButton = UIButton()
        storeButton.setImage(Images.store, for: .normal)
        view.addSubview(storeButton)
        storeButton.translatesAutoresizingMaskIntoConstraints = false
        storeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        storeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        storeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        storeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        
        storeButton.addTarget(self, action: #selector(goToStore), for: .touchUpInside)
    }
    
    @objc func goToStore() {
    }
    
    @objc func goToCoins() {
    }
    
    @objc func goToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    private func addBackgroundLayer() {
        view.addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        back.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        backgroundConstraint = back.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        backgroundConstraint?.isActive = true
        back.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2).isActive = true
        
        shootingStar.add(in: view)
        shootingStar.startAnimation()
    }
    
    private func addCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 150, bottom: 0, right: 150)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        collectionView.backgroundColor = .clear
        collectionView.contentInset = contentInset
        collectionView.delegate = self
        
        collectionView.register(WorldViewCell.self, forCellWithReuseIdentifier: WorldViewCell.cellIdentifier)
        collectionView.dataSource = viewModel
    }
    
    private func addParallaxElements() {
        let sceneContainer = SKView()
        sceneContainer.backgroundColor = .clear
        view.addSubview(sceneContainer)
        sceneContainer.frame = view.frame
        
        let scene = DashboardScene()
        scene.size = sceneContainer.frame.size
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .aspectFill
        sceneContainer.presentScene(scene)
    }
    
    func pulseCell(at index: Int) {
        if let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { finished in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [.curveEaseIn], animations: {
                    cell.transform = CGAffineTransform.identity
                }, completion: nil)
            })
        }
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let position = offset.x
        if position < 0 || position > view.frame.width * 2 { return }
        if position > 0 {
            backgroundConstraint?.constant = -position*0.5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.row)
    }
}
