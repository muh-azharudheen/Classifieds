//
//  DetailViewControllerTest.swift
//  ClassifiedsTests
//
//  Created by Muhammed Azharudheen on 15/11/2021.
//

import XCTest
@testable import Classifieds

class DetailViewControllerTests: XCTestCase {
    
    func test_DetailViewControllerViewModel() {
        
        let title = "Test Title"
        let subTitle = "Test Sub Title"
        let price = "Test Price"
        let viewModel = DetailViewModel(title: title, subTitle: subTitle, price: price, imageId: "")
        
        let sut = makeSUT(viewModel: viewModel)
        _ = sut.view
                
        XCTAssertEqual(sut.labelTitle?.text, title)
        XCTAssertEqual(sut.labelSubTitle?.text, subTitle)
        XCTAssertEqual(sut.labelPrice?.text, price)
    }
    
    private func makeSUT(viewModel: DetailViewModel) -> DetailViewController {
        let controller = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.viewModel = viewModel
        return controller
    }
    
}
