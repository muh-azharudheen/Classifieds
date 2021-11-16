//
//  ClassifiedsListViewModel.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 15/11/2021.
//

import ImageCacher

class ClassifiedsListViewModel: ClassifiedsListable {
    
    private var classified: Classified
    
    init(classified: Classified) {
        self.classified = classified
    }
    
    var title: String { classified.name }
    
    var subTitle: String { classified.price }
    
    func loadImage(imageView: UIImageView?) {
        guard let id = classified.imageId else { return }
        imageView?.loadImage(mode: .thumbnail, imageId: id, placeholder: #imageLiteral(resourceName: "placeholder"), url: classified.thumbnailURL)
    }
}
