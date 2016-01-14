//
//  Square.swift
//  SOLIDExample
//
//  Created by Harlan Kellaway on 1/14/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import Foundation

class Square: Rectangle {
    
    override func setHeight(value: Double) {
        self.myHeight = value
        self.myWidth = value
    }
    
    override func setWidth(value: Double) {
        self.myWidth = value
        self.myHeight = value
    }
    
}