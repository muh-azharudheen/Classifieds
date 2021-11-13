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
        
        let errorCompletion: (Error) -> Void = { error in
            DispatchQueue.main.async {
                completion(.failure(error: error))
            }
        }
        
        let successCompletion: (T) -> Void = { item in
            DispatchQueue.main.async {
                completion(.success(item))
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                errorCompletion(error)
                return
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    successCompletion(decoded)
                } catch {
                    errorCompletion(error)
                }
            } else {
                errorCompletion(UnexpectedValuesError())
            }
        }.resume()
    }
}
