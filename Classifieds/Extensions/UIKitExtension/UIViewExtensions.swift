//
//  UIViewExtensions.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import UIKit

extension UIView {
    
    func fill(leading: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, top: NSLayoutYAxisAnchor? = nil, insets: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: insets.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -insets.right).isActive = true
        }
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: insets.top).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom).isActive = true
        }
    }
}
