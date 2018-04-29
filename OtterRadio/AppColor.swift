//
//  AppColor.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/24/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import Foundation
import UIKit

enum AppColor: UInt32 {
    
    // CSUMB Hex Codes
    case Blue = 0x63decb
    case Beige = 0x238eb2
    case Gray = 0x66c8c7
    case GoldenYellow = 0xFFDD69
    
    var color: UIColor {
        return UIColor(hex: rawValue)
    }
}

extension UIColor {
    
    public convenience init(hex: UInt32) {
        let mask = 0x000000FF
        
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
}
