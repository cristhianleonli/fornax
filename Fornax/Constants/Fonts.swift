//
//  Fonts.swift
//  Fornax
//
//  Created by Cristhian León on 7/29/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit

struct Fonts {
    
    static var coins: UIFont {
        return createFont(font: .righteous, size: 19)
    }
    
    static var worldLabel: UIFont {
        return createFont(font: .righteous, size: 28)
    }
    
    static var mainLabel: UIFont {
        return createFont(font: .righteous, size: 18)
    }
}

fileprivate extension Fonts {
    
    enum FontType: String {
        case righteous = "Righteous-Regular"
        case nebulous = "Nebulous-Regular"
    }
    
    /**
     Creates a font given a weight and size
     - Parameter weight: enum value defined
     - Parameter size: enum value defined
     - Returns: the font created if the name exists,
     otherwise the system font
     */
    static func createFont(font: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
