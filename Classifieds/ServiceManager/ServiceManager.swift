//
//  ServiceManager.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

struct UnexpectedValuesError: Error { }

extension APIServiceProtocol {
    
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Result<T>) -> Void) {
        dataRequest(request: request) {
            switch $0 {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error: UnexpectedValuesError()))
                }
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}

class ServiceManager: APIServiceProtocol {
    
    private init() { }
    
    static let shared = ServiceManager()
    
    func dataRequest(request: URLRequest, completion: @escaping (Result<Data>) -> Void) {
        requestService(request: request, completion: completion)
    }
}

private extension ServiceManager {
    
    func requestService(request: URLRequest, completion: @escaping (Result<Data>) -> Void) {
        
        let errorCompletion: (Error) -> Void = { error in
            DispatchQueue.main.async {
                completion(.failure(error: error))
            }
        }
        
        let successCompletion: (Data) -> Void = { item in
            DispatchQueue.main.async {
                completion(.success(item))
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                errorCompletion(error)
                return
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                successCompletion(data)
            } else {
                errorCompletion(UnexpectedValuesError())
            }
        }.resume()
    }
}
