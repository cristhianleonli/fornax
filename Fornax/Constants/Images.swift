//
//  Images.swift
//  Fornax
//
//  Created by Cristhian León on 8/1/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit

struct Images {
    
    static let title = findImageBy(name: "title")
    
    static let gear = findImageBy(name: "gear")
    
    static let backIcon = findImageBy(name: "back")
    
    static let homeIcon = findImageBy(name: "home")
    
    static let coins = findImageBy(name: "coins")
    
    static let store = findImageBy(name: "store")
    
    static let developer = findImageBy(name: "groot_games")
    
    struct Planets {
        
        static let red = findImageBy(name: "red_planet")
        
        static let blue = findImageBy(name: "blue_planet")
        
        static let yellow = findImageBy(name: "yellow_planet")
        
        static let cold = findImageBy(name: "cold_planet")
        
        static let water = findImageBy(name: "water_planet")
        
        static let explode = findImageBy(name: "explode_planet")
        
        static let unknown = findImageBy(name: "unknown_planet")
    }
    
    struct Background {
        
        static let spaceRocks = findImageBy(name: "space_rocks")
        
        static let shootingStar = findImageBy(name: "star")
        
        static let mainBackground = findImageBy(name: "background")
        
        static let sideRocks = findImageBy(name: "black_mountains")
        
        static let downRocks = findImageBy(name: "down_mountains")
        
        static let rock1 = findImageBy(name: "rock_1")
        
        static let rock2 = findImageBy(name: "rock_2")
    }
}

fileprivate extension Images {
    
    /**
     Finds an image with a given name
     - Parameter name: String with the name of the image
     - Returns: if image does not exist returns empty image,
     otherwise returns the found image
     */
    static func findImageBy(name: String) -> UIImage {
        return UIImage(named: name) ?? UIImage()
    }
}
