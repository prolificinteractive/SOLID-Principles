//
//  NotSOLIDRectangle.swift
//  SOLIDExample
//
//  Created by Harlan Kellaway on 1/14/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Foundation

class NotSOLIDRectangle {
    
    internal var myHeight: Double = 0
    internal var myWidth: Double = 0
    
    func setHeight(value: Double) {
        self.myHeight = value
    }
    
    func setWidth(value: Double) {
        self.myWidth = value
    }
    
    func height() -> Double {
        return self.myHeight
    }
    
    func width() -> Double {
        return self.myWidth
    }
    
    func area() -> Double {
        return self.height() * self.width()
    }
    
}