//
//  Todos_Tests.swift
//  Todo Test Tests
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import XCTest
import Combine
@testable import Todo_Test

class API_Tests: XCTestCase {
    
    private let api = API(session: URLSession.shared)
    
    
    func testFetch() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "test", withExtension: "json") else {
            XCTFail("Missing file: test.json")
            return
        }
        
        let request = MockRequest(path: url.path)
        let expectation = self.expectation(description: "Fetch")
        let response: AnyPublisher<MockEntity, APIError> = api.fetch(request: request)
        let subscription = response
            .first()
            .sink { completion in
                switch completion {
                case .failure(let error): XCTFail("Failed retrieve value \(error)")
                case .finished: break
                }
            expectation.fulfill()
        } receiveValue: { (value) in
            XCTAssertEqual(value.message, "Hello, world")
        }
        waitForExpectations(timeout: 5, handler: nil)
        subscription.cancel()
    }
    
    
    func testFetchFailure() {
        let request = MockRequest(path: "")
        let expectation = self.expectation(description: "FetchFailure")
        let response: AnyPublisher<MockEntity, APIError> = api.fetch(request: request)
        let subscription = response
            .first()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, APIError.unknown)
                case .finished:
                    XCTFail("Shall failure")
                }
            expectation.fulfill()
        } receiveValue: { (value) in
            XCTFail("Shall failure")
        }
        waitForExpectations(timeout: 5, handler: nil)
        subscription.cancel()
    }
    
    
    func testFetchDecodeFailure() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "test", withExtension: "json") else {
            XCTFail("Missing file: test.json")
            return
        }
        
        let request = MockRequest(path: url.path)
        let expectation = self.expectation(description: "FetchDecodeFailure")
        let response: AnyPublisher<String, APIError> = api.fetch(request: request)
        let subscription = response
            .first()
            .sink { completion in
                switch completion {
                case .failure(let failure):
                    XCTAssertEqual(failure, APIError.decodingError)
                case .finished:
                    XCTFail("Decoding shall failure")
                }
            expectation.fulfill()
        } receiveValue: { (value) in
            XCTFail("Decoding shall failure")
        }
        waitForExpectations(timeout: 5, handler: nil)
        subscription.cancel()
    }

}


fileprivate struct MockEntity: Codable {
    var message: String
}


fileprivate struct MockRequest: APIRequest {
    var path: String
    var request: URLRequest {
        let url = URL(fileURLWithPath: path)
        return URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringCacheData,
            timeoutInterval: 10)
    }
}
