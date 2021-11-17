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
        let sut = makeSUT(serviceProtocol: MockServiceProtocol(jsonString: ""))
        let expectation = expectation(description: "waiting for request to be completed")
        var result: Result<[Classified]>?
        sut.loadClassified {
            result = $0
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
        guard let result = result else {
            XCTFail("couldnt complete request")
            return
        }
        guard case Result<[Classified]>.failure(_) =  result else {
            XCTFail("Expected Failure on empty json string, but received success")
            return
        }
    }
    
    func test_success_onLoadingSingleClassified() {
        let array = [
            createJsonString(created_at: "2019-02-24 04:04:17.566515", price: "AED 5", name: "Notebook", uid: "4878bf592579410fba52941d00b62f94", image_id: "9355183956e3445e89735d877b798689", imageurl: nil, imagethumbnailURL: nil)
        ]
        
        guard let jsonString = jsonString(array: array) else { return }
        
        let sut = makeSUT(serviceProtocol: MockServiceProtocol(jsonString: jsonString))
        let expectation = expectation(description: "waiting for request to be completed")
        var result: Result<[Classified]>?
        sut.loadClassified {
            result = $0
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
        guard let result = result else {
            XCTFail("couldnt complete request")
            return
        }
        guard case Result<[Classified]>.success(let items) =  result else {
            XCTFail("Expected Success with a single classified Object, but received failure")
            return
        }
        XCTAssertEqual(items.count, 1)
    }
    
    
    private func makeSUT(serviceProtocol: APIServiceProtocol) -> ClassifiedsLoader {
        ClassifiedsLoader(serviceProtocol: serviceProtocol)
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
}

class MockServiceProtocol: APIServiceProtocol {
    
    private var jsonString: String
    
    init(jsonString: String) {
        self.jsonString = jsonString
    }
    
    func request<T>(request: URLRequest, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        
        let errorCompletion: (Error) -> Void = { error in
            DispatchQueue.main.async {
                completion(.failure(error: error))
            }
        }
        
        let successCompletion: (T) -> Void = { item in
            DispatchQueue.main.async {
                completion(.success(item))
            }
        }
        
        guard let data = jsonString.data(using: .utf8) else { return }
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            successCompletion(decoded)
        } catch {
            print(error)
            errorCompletion(error)
        }
    }
}
