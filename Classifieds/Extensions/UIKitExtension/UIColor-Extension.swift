//
//  UIColor-Extension.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 12/11/2021.
//

import UIKit

extension UIColor {
    
    static var primaryDark: UIColor {
        UIColor(named: "primaryDark") ?? .black
    }
    
    static var secondaryDark: UIColor {
        UIColor(named: "secondaryDark") ?? .black
    }
    
    static var primaryLight: UIColor {
        UIColor(named: "primaryLight") ?? .black
    }
}

@objc extension UIColor {
    static var primaryTint: UIColor {
        UIColor(named: "primaryTintColor") ?? .black
    }
}
