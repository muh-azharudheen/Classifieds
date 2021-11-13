//
//  ServiceManager.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

class ServiceManager: APIServiceProtocol {
    
    private init() { }
    
    static let shared = ServiceManager()
    
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Result<T>) -> Void) {
        requestService(request: request, completion: completion)
    }
}

private extension ServiceManager {
    
    private struct UnexpectedValuesError: Error { }
    
    func requestService<T: Decodable>(request: URLRequest, completion: @escaping (Result<T>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error: error))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(decoded))
                    return
                }
                completion(.failure(error: UnexpectedValuesError()))
                
            } else {
                completion(.failure(error: UnexpectedValuesError()))
            }
        }.resume()
    }
}
