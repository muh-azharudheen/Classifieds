//
//  CFont.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 12/11/2021.
//

import UIKit

enum CFont {
    case quickSand
    
    var fontName: String { "quicksand" }
    
    func font(with size: CGFloat) -> UIFont {
        UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

@objc extension UIFont {
    static func cFont(with size: CGFloat) -> UIFont {
        CFont.quickSand.font(with: size)
    }
}
