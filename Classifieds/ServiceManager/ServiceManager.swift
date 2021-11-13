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
        
    }
}
