//
//  ClassifiedViewControllerTests.swift
//  ClassifiedsTests
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import XCTest
@testable import Classifieds

class ClassifiedViewControllerTests: XCTestCase {

    private lazy var viewModel = ClassifiedsViewModel(loader: loader)
    private lazy var loader = createLoader()
    
    func testTopLabels() {
        let sut = makeSUT()
        
        _ = sut.view
        
        XCTAssertEqual(sut.labelTitle.text, "home.welcome.message".localized)
        XCTAssertEqual(sut.labelSubTitle.text, Date().toString())
        XCTAssertEqual(sut.labelListingTitle.text, "home.listing.title".localized)
    }
    
    func makeSUT() -> ClassifiedsViewController {
        ClassifiedsViewController(viewModel: viewModel)
    }
    
    func createLoader() -> ClassifiedsLoaderProtocol {
        MockLoader()
    }
}

private class MockLoader: ClassifiedsLoaderProtocol {
    func loadClassified(completion: @escaping (Result<[Classified]>) -> Void) { }
}
