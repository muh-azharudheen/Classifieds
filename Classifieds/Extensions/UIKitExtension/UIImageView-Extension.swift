//
//  UIImageView-Extension.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import UIKit
import ImageCacher

extension UIImageView {
    
    func loadImage(with url: URL?) {
        loadImageUsingCache(url: url, placeholder: #imageLiteral(resourceName: "placeholder"))
    }
}
