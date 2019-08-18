//
//  MainViewController.swift
//  Fornax
//
//  Created by Cristhian León on 8/1/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MainViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private let itemsPerRow: CGFloat = 1
    
    private let itemsCount: Int = 2
    
    private lazy var itemSize = CGSize(width: view.frame.width, height: view.frame.height)
    
    private let contentInset: UIEdgeInsets = .zero
    
    private let mainCell: Int = 0
    
    private let settingsCell: Int = 1
    
    private let background = ParallaxBackground()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackground()
        addCollection()
    }
    
    private func addBackground() {
        view.addSubview(background)
        background.backgroundColor = .green
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        background.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func addCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.backgroundColor = .clear
        collectionView.contentInset = contentInset
        collectionView.delegate = self
        
        // register cells
        collectionView.register(MainViewCell.self,
                                forCellWithReuseIdentifier: MainViewCell.cellIdentifier)
        collectionView.register(SettingsViewCell.self,
                                forCellWithReuseIdentifier: SettingsViewCell.cellIdentifier)
        collectionView.dataSource = self
    }
}

extension MainViewController: ParentViewDelegate {
    func showMainTab() {
        collectionView.selectItem(at: IndexPath(row: mainCell,
                                                section: 0),
                                  animated: true, scrollPosition: .left)
    }
    
    func showSettingsTab() {
        collectionView.selectItem(at: IndexPath(row: settingsCell,
                                                section: 0),
                                  animated: true, scrollPosition: .left)
    }
    
    func startGame() {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardViewController")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
}

extension MainViewController: UICollectionViewDelegate {
    // when scroll moves
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.x < 0 || offset.x > view.frame.width { return }
        background.didMove(to: offset.x)
        // extract the first cell
        if let firstCell = collectionView.cellForItem(at: IndexPath(row: mainCell, section: 0)) as? MainViewCell {
            // tell the cell moves elements
            firstCell.setScroll(value: offset.x)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCell.cellIdentifier,
                                                          for: indexPath)
            if let mainCell = cell as? MainViewCell {
                mainCell.setDelegate(self)
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsViewCell.cellIdentifier,
                                                      for: indexPath)
        if let settingsCell = cell as? SettingsViewCell {
            settingsCell.setDelegate(self)
        }
        
        return cell
    }
}
