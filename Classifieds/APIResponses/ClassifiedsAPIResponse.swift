//
//  ClassifiedsAPIResponse.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

struct ClassifiedsAPIResponse: Decodable {
    
    let results: [Response]?
    
    class Response: Decodable {
        let name: String?
        let created_at: String?
        let price: String?
        let uid: String?
        let image_ids: [String]?
        let image_urls: [String]?
        let image_urls_thumbnails: [String]?
    }
}
