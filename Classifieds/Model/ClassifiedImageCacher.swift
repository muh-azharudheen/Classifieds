//
//  ClassifiedImageCacher.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 15/11/2021.
//

import UIKit
import ImageCacher

class ClassifiedImageCacher {
    
    enum Mode {
        case original
        case thumbnail
        
        func key(for imageId: String) -> String {
            switch self {
            case .original: return "original" + imageId
            case .thumbnail: return "thumbnail" + imageId
            }
        }
    }
    
    class func loadImage(in imageView: UIImageView?, with url: URL?, mode: Mode, imageId: String, placeholder: UIImage?) {
//        imageView?.loadImage(with: url)
    }
}
