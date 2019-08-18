//
//  Loader.swift
//  Fornax
//
//  Created by Cristhian León on 7/30/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit

class Loader: UIView {
    
    private var widthConstraint: NSLayoutConstraint?
    
    private var totalWidthConstraint: NSLayoutConstraint?
    
    private let innerLoader = UIView()
    
    func setup(parentView: UIView, bottomAnchor: NSLayoutYAxisAnchor,
               width: CGFloat, height: CGFloat) {
        parentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        totalWidthConstraint = self.widthAnchor.constraint(equalToConstant: width)
        totalWidthConstraint?.isActive = true
        
        self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        layer.cornerRadius = height / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
        innerLoader.backgroundColor = UIColor.white
        addSubview(innerLoader)
        innerLoader.translatesAutoresizingMaskIntoConstraints = false
        
        innerLoader.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        innerLoader.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        innerLoader.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        widthConstraint = innerLoader.widthAnchor.constraint(equalToConstant: 0)
        widthConstraint?.isActive = true
        
        innerLoader.layer.cornerRadius = height / 2
        innerLoader.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func setValue(_ value: Int) {
        let v: CGFloat = (value > 100 ? 100 : value < 0 ? 0 : CGFloat(value))
        
        if v == 100 {
            innerLoader.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner,
                                               .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        } else {
            innerLoader.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
        
        let total = totalWidthConstraint?.constant ?? 0
        let current = total * v / 100
        self.widthConstraint?.constant = current
    }
}
