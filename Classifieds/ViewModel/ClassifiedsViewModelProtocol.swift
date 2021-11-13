//
//  ClassifiedsViewModelProtocol.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

protocol ClassifiedsViewModelProtocol {
    var reloadClosure: (() -> Void)? { get set }
    var showDetailClosure: ((DetailViewModel) -> Void)? { get set }
    var title: String { get }
    var subTitle: String { get }
    
    func numberOfLists() -> Int
    func list(index: Int) -> ListViewModel
    func loadLists()
    func selectItem(at index: Int)
}
