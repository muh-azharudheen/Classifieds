//
//  UIImageView+ImageCache.swift
//  ImageCacher
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

public extension UIImageView {
    
    func loadImageUsingCache(url: URL?, placeholder: UIImage?) {
        guard let url = url else {
            image = placeholder
            return
        }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString)  {
            image = cachedImage
            return
        }

        image = placeholder
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self?.image = placeholder
                }
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self?.image = image
                }
            }

        }).resume()
    }
}
