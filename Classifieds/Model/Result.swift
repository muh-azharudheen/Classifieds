//
//  Result.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(error: Error)
}
