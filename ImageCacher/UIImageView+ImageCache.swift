//
//  UIImageView+ImageCache.swift
//  ImageCacher
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

public extension UIImageView {
    
    func loadImageUsingCache(url: URL?) {
        guard let url = url else { return }
        image = nil

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString)  {
            image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self?.image = nil
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
