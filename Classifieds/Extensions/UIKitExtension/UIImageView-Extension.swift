//
//  UIImageView-Extension.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import UIKit
import ImageCacher

@objc
extension UIImageView {
    func loadImage(mode: Int, imageId: String, placeholder: UIImage?, url: URL?) {
        guard let mode = Mode(rawValue: mode) else { return }
        loadImageUsingCache(url: url, key: mode.key(for: imageId), placeholder: placeholder)
    }
}


extension UIImageView {
    
    enum Mode: Int {
        case original = 0
        case thumbnail = 1
        
        func key(for imageId: String) -> String {
            switch self {
            case .original: return "original" + imageId
            case .thumbnail: return "thumbnail" + imageId
            }
        }
    }
    
    
    func loadImage(mode: Mode, imageId: String, placeholder: UIImage?, url: URL?) {
        loadImageUsingCache(url: url, key: mode.key(for: imageId), placeholder: #imageLiteral(resourceName: "placeholder"))
    }
}
