//
//  TodoRequest.swift
//  Todo Test Tests
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import XCTest
@testable import Todo_Test

class TodoRequest_Tests: XCTestCase {


    func testProtocolCompliance() throws {
        guard TodoRequest.self is APIRequest.Type else {
            XCTFail("Doesn't conform APIRequest protocol.")
        }
    }
    
    
    func testRequestParameters() throws {
        let request = TodoRequest(id: 1)
        
        XCTAssertEqual(request.request.httpMethod, "GET")
        XCTAssertEqual(request.request.url?.lastPathComponent, "1")
    }


}
