//
//  DashboardViewModel.swift
//  Fornax
//
//  Created by Cristhian León on 7/30/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit
import Foundation

class DashboardViewModel: NSObject {
    
    weak var view: DashboardViewController?
    
    public private(set) var dataSource = [World]()
    
    private let redPlanetCell = 0
    
    private let bluePlanetCell = 1
    
    private let unknownPlanetCell = 2
    
    override init() {
        super.init()
        
        let images: [(String, UIImage)] = [
            (Strings.Planets.red, Images.Planets.red),
            (Strings.Planets.blue, Images.Planets.blue),
            (Strings.Planets.yellow, Images.Planets.unknown)
        ]
        
        for (name, image) in images {
            dataSource.append(World(name: name, image: image))
        }
    }
    
    func selectItem(at index: Int) {
        if index == unknownPlanetCell {
            view?.pulseCell(at: index)
        } else {
        }
    }
}

// MARK: Datasource
extension DashboardViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorldViewCell.cellIdentifier, for: indexPath)
        if let worldCell = cell as? WorldViewCell {
            worldCell.prepareForReuse()
            worldCell.world = dataSource[indexPath.row]
        }
        return cell
    }
}
