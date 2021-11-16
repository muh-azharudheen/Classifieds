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
        let jsonString = "{\"results\":[{\"created_at\":\"2019-02-24 04:04:17.566515\",\"price\":\"AED 5\",\"name\":\"Notebook\",\"uid\":\"4878bf592579410fba52941d00b62f94\",\"image_ids\":[\"9355183956e3445e89735d877b798689\"],\"image_urls\":[\"https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689?AWSAccessKeyId=ASIASV3YI6A4ZISZFVEE&Signature=2x%2FaEl5U1KePYTb%2Bp2fUqtfzau8%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEMP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIFxShQ%2BBKtMixDfKs2S%2BJPAaZM%2FfE5fK9t%2BwuZkXc3nqAiEAuVciLTJ%2Bsu0a3pEBaigD7fp4bYb%2F7dwk17Hu3x%2BNxxcqlAIIexADGgwxODQzOTg5NjY4NDEiDOR8hap7ayqXGwMB6SrxAew6sqeqPwsupTDqNI4M6FuliPfTrvRcC3NSP5zeJtjAUKogiuObW1C449xhehhoAk4TxRXVxErX%2BuIkWOvjMgUBDDB9SZVi5hNeKUyvKumqfyeIWTBPQqsZcySPb8RBY1QpWSI3isihm8%2FOtjBz4gSmFfRpgqY8ssux82GsZUmsioiZfOc5DZ0wxcYFQb0%2Bp0MzMRxdWUKkMwv2vlo4WjEfpylUonx28EKWhCimy1GUYTpEYl42Tm4DhLU5mcneegPLu2NDQ8ynwp1bu%2FYPlWG7w1w3lUKg0zhLhAcofywkIzm4pOyfQyrkxz50FHly%2BiEwz8TKjAY6mgFvADRouOoruZOS8O0L%2BsIujEpDwbfbJoQgZ9Ic9YEEPVXMD6q%2BbvyyCP79iJQor2IxyAuAvds%2BAewHon33xFVMN2yFpvpGMDg1LtKDCceLd8r4MaA4x8N0lowKwvYsm%2B%2FmSGg%2BgWu8jf7WIAWQ2fNNIjK16B00nMUksXRNEY%2BWMFFfPEAfplSFFo2kT4JujxgxF4EdtMam%2FWF1&Expires=1637003362\"],\"image_urls_thumbnails\":[\"https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689-thumbnail?AWSAccessKeyId=ASIASV3YI6A4ZISZFVEE&Signature=kBa2Ais%2BoLgxR9T1y25qaTjUqbA%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEMP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIFxShQ%2BBKtMixDfKs2S%2BJPAaZM%2FfE5fK9t%2BwuZkXc3nqAiEAuVciLTJ%2Bsu0a3pEBaigD7fp4bYb%2F7dwk17Hu3x%2BNxxcqlAIIexADGgwxODQzOTg5NjY4NDEiDOR8hap7ayqXGwMB6SrxAew6sqeqPwsupTDqNI4M6FuliPfTrvRcC3NSP5zeJtjAUKogiuObW1C449xhehhoAk4TxRXVxErX%2BuIkWOvjMgUBDDB9SZVi5hNeKUyvKumqfyeIWTBPQqsZcySPb8RBY1QpWSI3isihm8%2FOtjBz4gSmFfRpgqY8ssux82GsZUmsioiZfOc5DZ0wxcYFQb0%2Bp0MzMRxdWUKkMwv2vlo4WjEfpylUonx28EKWhCimy1GUYTpEYl42Tm4DhLU5mcneegPLu2NDQ8ynwp1bu%2FYPlWG7w1w3lUKg0zhLhAcofywkIzm4pOyfQyrkxz50FHly%2BiEwz8TKjAY6mgFvADRouOoruZOS8O0L%2BsIujEpDwbfbJoQgZ9Ic9YEEPVXMD6q%2BbvyyCP79iJQor2IxyAuAvds%2BAewHon33xFVMN2yFpvpGMDg1LtKDCceLd8r4MaA4x8N0lowKwvYsm%2B%2FmSGg%2BgWu8jf7WIAWQ2fNNIjK16B00nMUksXRNEY%2BWMFFfPEAfplSFFo2kT4JujxgxF4EdtMam%2FWF1&Expires=1637003362\"]}]}"
        
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
            errorCompletion(error)
        }
    }
}
