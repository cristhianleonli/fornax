//
//  GradientView.swift
//  Fornax
//
//  Created by Cristhian León on 7/30/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit

class RadialGradient: CALayer {
    
    var startColor: UIColor!
    
    var endColor: UIColor!
    
    private override init() {
        super.init()
        setNeedsDisplay()
    }
    
    static func create(startColor: UIColor, endColor: UIColor) -> RadialGradient {
        let layer = RadialGradient()
        layer.startColor = startColor
        layer.endColor = endColor
        return layer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in context: CGContext) {
        let gradLocationsNum = 2
        let gradLocations:[CGFloat] = [0.0, 1.0]
        
        var gradColors = [CGFloat].init(repeating: 0, count: 8)
        
        var red:CGFloat = 0.0, green:CGFloat = 0.0, blue:CGFloat = 0.0, alpha:CGFloat = 0.0
        startColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        gradColors[0] = red
        gradColors[1] = green
        gradColors[2] = blue
        gradColors[3] = alpha
        
        endColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        gradColors[4] = red
        gradColors[5] = green
        gradColors[6] = blue
        gradColors[7] = alpha
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: gradColors, locations: gradLocations, count: gradLocationsNum)
        
        let gradCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height)
        let gradRadius = min(bounds.size.width, bounds.size.height)
        
        context.drawRadialGradient(gradient!, startCenter: gradCenter, startRadius: 0, endCenter: gradCenter, endRadius: gradRadius, options: .drawsAfterEndLocation)
    }
}
