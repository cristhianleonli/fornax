//
//  Timeout.swift
//  Fornax
//
//  Created by Cristhian León on 8/2/18.
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import Foundation

class Timeout: NSObject {
    private var timer: Timer?
    private var callback: (() -> Void)?
    
    init(delaySeconds: Double, immediately: Bool = false, callback: @escaping () -> Void) {
        super.init()
        self.callback = callback
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(delaySeconds),
                                          target: self, selector: #selector(invoke), userInfo: nil, repeats: true)
        if immediately {
            invoke()
        }
    }
    
    @objc func invoke() {
        self.callback?()
    }
    
    func cancel() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
