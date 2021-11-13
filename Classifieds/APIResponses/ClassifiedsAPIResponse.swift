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

extension ClassifiedsAPIResponse.Response {
    
    func classified() -> Classified? {
        guard let id = uid else { return nil }
        let thumbNailURL = createURL(from: image_urls_thumbnails)
        let imageURL = createURL(from: image_urls)
        return Classified(dateCreated: createdDate(), price: price ?? "", name: name ?? "", id: id, imageId: image_ids?.first, imageURL: imageURL, thumbnailURL: thumbNailURL)
    }
    
    private func createURL(from array: [String]?) -> URL? {
        guard let urlString = array?.first else { return nil }
        return URL(string: urlString)
    }
    
    // Assuming Locale
    private func createdDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss.SSSSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        guard let created = created_at else { return Date() }
        return formatter.date(from: created) ?? Date()
    }
}
