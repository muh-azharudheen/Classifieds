//
//  Classified.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

class Classified {
    
    var dateCreated: Date
    var price: String
    var name: String
    var uuid: UUID
    var imageURL: URL?
    var thumbnailURL: URL?
    
    init(dateCreated: Date, price: String, name: String, uuid: UUID, imageURL: URL?, thumbnailURL: URL?) {
        self.dateCreated = dateCreated
        self.price = price
        self.name = name
        self.uuid = uuid
        self.imageURL = imageURL
        self.thumbnailURL = thumbnailURL
    }
}
