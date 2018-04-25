//
//  AppFontAmericanTypewriter.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/24/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import Foundation
import UIKit

struct AmericanTypewriter {
    // Font string literal.
    static let regular = "AmericanTypewriter"
    static let bold = "AmericanTypewriter-Bold"
    static let condensed = "AmericanTypewriter-Condensed"
    static let condensedBold = "AmericanTypewriter-CondensedBold"
    static let condensedLight = "AmericanTypewriter-CondensedLight"
    static let light = "AmericanTypewriter-Light"
}

extension UIFont {
    
    class func americanTypewriterReqular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AmericanTypewriter.regular, size: size)!
    }
    
    class func americanTypewriterBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AmericanTypewriter.bold, size: size)!
    }
    
    class func americanTypewriterCondensed(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AmericanTypewriter.condensed, size: size)!
    }
    
    class func americanTypewriterCondensedBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AmericanTypewriter.condensedBold, size: size)!
    }
    
    class func americanTypewriterCondensedLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AmericanTypewriter.condensedLight, size: size)!
    }
    
    class func americanTypewriterLigt(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AmericanTypewriter.light, size: size)!
    }
}
