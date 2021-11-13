//
//  ClassifiedsLoaderProtocol.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

protocol ClassifiedsLoaderProtocol {
    func loadClassified(completion: @escaping (Result<[Classified]>) -> Void)
}
