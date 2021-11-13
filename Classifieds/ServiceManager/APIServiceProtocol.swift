//
//  APIServiceProtocol.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

protocol APIServiceProtocol {
    
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Result<T>)-> Void)
    
}
