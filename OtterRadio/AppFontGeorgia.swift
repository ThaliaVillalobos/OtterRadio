//
//  AppFontName.swift
//  OtterRadio
//
//  Created by Thalia Villalobos on 4/24/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import Foundation
import UIKit

struct AppFontGeorgia {
    // Font string literal.
    static let regular = "Georgia-Regular"
    static let bold = "Georgia-Bold"
    static let italic = "Georgia-Italic"
    static let light = "Georgia-Light"
    static let heavy = "Georgia-Heavy"
}

extension UIFont {
    
    class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontGeorgia.regular, size: size)!
    }
    
    class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontGeorgia.bold, size: size)!
    }
    
    class func myHeavySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontGeorgia.heavy, size: size)!
    }
    
    class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontGeorgia.italic, size: size)!
    }
    
    class func myLightSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontGeorgia.light, size: size)!
    }
}
