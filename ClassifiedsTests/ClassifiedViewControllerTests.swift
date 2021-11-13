//
//  ClassifiedViewControllerTests.swift
//  ClassifiedsTests
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import XCTest
@testable import Classifieds

class ClassifiedViewControllerTests: XCTestCase {
    
    private lazy var loader = MockLoader()
    
    func testTopLabels() {
        let sut = makeSUT()
        
        _ = sut.view
        
        XCTAssertEqual(sut.labelTitle.text, "home.welcome.message".localized)
        XCTAssertEqual(sut.labelSubTitle.text, Date().toString())
        XCTAssertEqual(sut.labelListingTitle.text, "home.listing.title".localized)
    }
    
    func test_datasourceIsEmptyWhenClassifiedsAreLoading() {
        
        let sut = makeSUT()
        _ = sut.view
        
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 0)
    }
    
    func test_datasourceWhenLoadingFinished() {
        
        let sut = makeSUT()
        _ = sut.view
        
        loader.classifieds = [
            .init(dateCreated: Date(), price: "AED 500", name: "Note Book", id: "1", imageId: nil, imageURL: nil, thumbnailURL: nil)
        ]
        
        loader.finishLodingClosure?()
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 1)
        
        loader.classifieds = [
            .init(dateCreated: Date(), price: "AED 500", name: "Note Book", id: "1", imageId: nil, imageURL: nil, thumbnailURL: nil),
            .init(dateCreated: Date(), price: "AED 200", name: "Text", id: "2", imageId: nil, imageURL: nil, thumbnailURL: nil)
        ]
        loader.finishLodingClosure?()
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 2)
    }
    
    func test_tableViewCell() {
        let sut = makeSUT()
        _ = sut.view
        loader.classifieds = [
            .init(dateCreated: Date(), price: "AED 500", name: "Note Book", id: "1", imageId: nil, imageURL: nil, thumbnailURL: nil)
        ]
        loader.finishLodingClosure?()
        
        let collectionview = sut.collectionView
        guard let cell = sut.collectionView.dataSource?.collectionView(collectionview, cellForItemAt: IndexPath(item: 0, section: 0)) as? ClassifiedListCell else {
            XCTFail("Could not deque cell")
            return
        }
        XCTAssertEqual(cell.labelTitle?.text, "Note Book")
        XCTAssertEqual(cell.labelSubTitle?.text, "AED 500")
    }
    
    func makeSUT(classifieds: [Classified] = []) -> ClassifiedsViewController {
        let viewModel = ClassifiedsViewModel(loader: loader)
        return ClassifiedsViewController(viewModel: viewModel)
    }
}

private class MockLoader: ClassifiedsLoaderProtocol {
    
    var classifieds = [Classified]()
    var finishLodingClosure: (()-> Void)?
        
    func loadClassified(completion: @escaping (Result<[Classified]>) -> Void) {
        finishLodingClosure = {
            completion(.success(self.classifieds))
        }
    }
}
