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
                let classifieds = response.results?.compactMap({ $0.classified() }) ?? []
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
