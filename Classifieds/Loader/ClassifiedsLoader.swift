//
//  ClassifiedsLoader.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation


class ClassifiedsLoader: ClassifiedsLoaderProtocol {
    
    private var serviceProtocol: APIServiceProtocol
    
    init(serviceProtocol: APIServiceProtocol) {
        self.serviceProtocol = serviceProtocol
    }
    
    func loadClassified(completion: @escaping (Result<[Classified]>) -> Void) {
        guard let request = urlRequest() else { return }
        load(request: request, completion: completion)
    }
    
    private func load(request: URLRequest, completion: @escaping (Result<[Classified]>) -> Void) {
        serviceProtocol.request(request: request) { (result: Result<ClassifiedsAPIResponse>) in
            switch result {
            case .success(let response):
                let classifieds = response.results?.compactMap({ $0.classified }) ?? []
                completion(.success(classifieds))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}

private extension ClassifiedsLoader {
    
    func urlRequest() -> URLRequest? {
        guard let url = URL(string: "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer") else { return nil }
        return URLRequest(url: url)
    }
}

private extension ClassifiedsAPIResponse.Response {
    
    var classified: Classified? {
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
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let created = created_at else { return Date() }
        return formatter.date(from: created) ?? Date()
    }
}
