//
//  ShootingStar.swift
//  Fornax
//
//  Created by Cristhian León on 8/4/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit

class ShootingStar: UIView {
    
    private let starSize: CGFloat = 30
    
    private var starIntermittence: Double = 0
    
    private var timer: Timeout?
    
    private let imageView = UIImageView(image: Images.Background.shootingStar)
    
    private var parentView: UIView {
        return superview ?? UIView()
    }
    
    /**
     Adds the view on the screen
     - Parameter parent: UIView where the star will be located
     */
    func add(in parent: UIView) {
        parent.addSubview(self)
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        
        frame = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        alpha = 0
    }
    
    /**
     Stars the shooting star animation
     - Parameter intermittence: every minutes the star will show up
     */
    func startAnimation(every intermittence: Double = 6) {
        starIntermittence = intermittence
        createAnimation()
    }
    
    /// Deletes the timer animation
    func stopAnimation() {
        timer?.cancel()
    }
    
    private func createAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
            self?.timer = Timeout(delaySeconds: self?.starIntermittence ?? 0, immediately: true) { [weak self] in
                guard
                    let height = self?.parentView.frame.height else { return }
                let random = CGFloat.random(in: 0...height/3)
                self?.moveStar(from: random)
            }
        }
    }
    
    private func moveStar(from y: CGFloat) {
        alpha = 1
        frame = CGRect(x: parentView.frame.width + starSize,
                            y: CGFloat(y),
                            width: starSize,
                            height: starSize)
        // animation
        UIView.animate(withDuration: 0.9, delay: 0, options: [.curveEaseInOut], animations: {[weak self] in
            let size = self?.starSize ?? 0
            let height = self?.parentView.frame.height ?? 0
            self?.alpha = 0
            self?.frame = CGRect(x: -size,
                                      y: (height / 2) + CGFloat(y),
                                      width: size,
                                      height: size)
            }, completion: nil)
    }
    
    deinit {
        timer?.cancel()
    }
}
