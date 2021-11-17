//
//  ClassifiedsLoaderTest.swift
//  ClassifiedsTests
//
//  Created by Muhammed Azharudheen on 16/11/2021.
//

import XCTest
@testable import Classifieds

class ClassifiedsLoaderTest: XCTestCase {
    
    func test_throwErrorWhenJsonStringIsEmpty() {
        let result = resultAfterLoadingClassifiedWithExpectation(with: "")
        let error = error(from: result)
        XCTAssertNotNil(error)
    }
    
    func test_success_onLoadingSingleClassified() {
        let array = [
            createJsonString(created_at: "2019-02-24 04:04:17.566515", price: "AED 5", name: "Notebook", uid: "4878bf592579410fba52941d00b62f94", image_id: "9355183956e3445e89735d877b798689", imageurl: nil, imagethumbnailURL: nil)
        ]
        
        guard let jsonString = jsonString(array: array) else { return }
        
        let classifieds = classifiedsAfterLoadingWithExpectation(jsonString: jsonString)
        XCTAssertEqual(classifieds?.count, 1)
    }
    
    func test_success_onLoadingMultipleClassified() {
        let array = [
            createJsonString(created_at: "2019-02-24 04:04:17.566515", price: "AED 5", name: "Notebook", uid: "4878bf592579410fba52941d00b62f94", image_id: "9355183956e3445e89735d877b798689", imageurl: nil, imagethumbnailURL: nil),
            createJsonString(created_at: "2019-02-24 04:04:17.566515", price: "AED 5", name: "Notebook", uid: "4878bf592579410fba52941d00b62f94", image_id: "9355183956e3445e89735d877b798689", imageurl: nil, imagethumbnailURL: nil),
            createJsonString(created_at: "2019-02-24 04:04:17.566515", price: "AED 5", name: "Notebook", uid: "4878bf592579410fba52941d00b62f94", image_id: "9355183956e3445e89735d877b798689", imageurl: nil, imagethumbnailURL: nil)
        ]
        
        guard let jsonString = jsonString(array: array) else { return }
        let classifieds = classifiedsAfterLoadingWithExpectation(jsonString: jsonString)
        XCTAssertEqual(classifieds?.count, 3)
    }
    
    func test_classifiedShouldBeOmittedIfuidFromResponseisNil() {
        let array = [
            createJsonString(created_at: "2019-02-24 04:04:17.566515", price: "AED 5", name: "Notebook", uid: nil, image_id: "9355183956e3445e89735d877b798689", imageurl: nil, imagethumbnailURL: nil),
            createJsonString(created_at: nil, price: nil, name: nil, uid: nil, image_id: nil, imageurl: nil, imagethumbnailURL: nil),
            createJsonString(created_at: nil, price: nil, name: "9355183956e3445e89735d877b798689", uid: nil, image_id: nil, imageurl: nil, imagethumbnailURL: nil)
        ]
        
        guard let jsonString = jsonString(array: array) else { return }
        let classifieds = classifiedsAfterLoadingWithExpectation(jsonString: jsonString)
        XCTAssertEqual(classifieds?.count, 0)
    }
    
    private func makeSUT(serviceProtocol: APIServiceProtocol) -> ClassifiedsLoader {
        ClassifiedsLoader(serviceProtocol: serviceProtocol)
    }
    
    private func resultAfterLoadingClassifiedWithExpectation(with jsonString: String) -> Result<[Classified]> {
        let sut = makeSUT(serviceProtocol: MockServiceProtocol(jsonString: jsonString))
        let expectation = expectation(description: "waiting for request to be completed")
        var result: Result<[Classified]>?
        sut.loadClassified {
            result = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
        guard let result = result else {
            fatalError("Couldnt convert response string to Result")
        }
        return result
    }
    
    private func classifiedsAfterLoadingWithExpectation(jsonString: String) -> [Classified]? {
        let result = resultAfterLoadingClassifiedWithExpectation(with: jsonString)
        return classifieds(from: result)
    }
    
    private func jsonString(array: [[String: Any?]]) -> String? {
        let dictionary = ["results": array]
        if let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    private func createJsonString(created_at: String?, price: String?, name: String?, uid: String?, image_id: String?, imageurl: String?, imagethumbnailURL: String?) -> [String: Any?] {
        var dict = [
            "created_at": created_at,
            "price": price,
            "name": name,
            "uid": uid,
        ] as [String: Any?]
        
        if let id = image_id {
            dict["image_ids"] = [id]
        }
        
        if let thumbnail = imagethumbnailURL {
            dict["image_urls_thumbnails"] = [thumbnail]
        }
        
        if let url = imageurl {
            dict["image_urls"] = [url]
        }
        return dict
    }
    
    private func error(from result: Result<[Classified]>) -> Error? {
        guard case Result<[Classified]>.failure(let error) = result else { return nil }
        return error
    }
    
    private func classifieds(from result: Result<[Classified]>) -> [Classified]? {
        guard case Result<[Classified]>.success(let classifieds) = result else { return nil }
        return classifieds
    }
}

class MockServiceProtocol: APIServiceProtocol {
    
    private var jsonString: String
    
    init(jsonString: String) {
        self.jsonString = jsonString
    }
    
    func dataRequest(request: URLRequest, completion: @escaping (Result<Data>) -> Void) {
        let data = jsonString.data(using: .utf8)!
        completion(.success(data))
    }
}
