//
//  ClassifiedsViewModel.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

class ClassifiedsViewModel {
    
    private var classifieds = [Classified]()
    
    private var loader: ClassifiedsLoaderProtocol
    
    init(loader: ClassifiedsLoaderProtocol) {
        self.loader = loader
    }
    
    var reloadClosure: (() -> Void)?
    
    var showDetailClosure: ((DetailViewModel) -> Void)?
    
    var errorClosure: ((Error) -> Void)?
    
    var title: String { "home.welcome.message".localized }
    
    var subTitle: String { Date().toString() }
    
    var listTitle: String { "home.listing.title".localized }
    
    func numberOfLists() -> Int {
        classifieds.count
    }
    
    func list(index: Int) -> ClassifiedsListable {
        ClassifiedsListViewModel(classified: classifieds[index])
    }
    
    func selectItem(at index: Int) {
        let item = classifieds[index].createDetailViewModel()
        showDetailClosure?(item)
    }
    
    func loadLists() {
        loader.loadClassified { [weak self] in
            switch $0 {
            case .success(let items):
                self?.handleResult(items: items)
            case .failure(let error):
                self?.errorClosure?(error)
            }
        }
    }
    
    private func handleResult(items: [Classified]) {
        classifieds = items
        reloadClosure?()
    }
}

private extension Classified {
    func createListViewModel() -> ClassifiedsListViewModel {
        ClassifiedsListViewModel(classified: self)
    }
    
    func createDetailViewModel() -> DetailViewModel {
        let viewModel = DetailViewModel(title: name, subTitle: dateCreated.toString(), price: price, imageId: imageId ?? "")
        if let url = imageURL {
            viewModel.imageURL = url
        }
        return viewModel
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd EEEE"
        return formatter.string(from: self)
    }
}


