//
//  TodosRequests.swift
//  Todo Test Tests
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import XCTest
@testable import Todo_Test

class TodosRequest_Tests: XCTestCase {

    func testProtocolCompliance() throws {        
        guard TodosRequest.self is APIRequest.Type else {
            XCTFail("Doesn't conform APIRequest protocol.")
        }
    }
    
    
    func testRequestParameters() throws {
        let request = TodosRequest()
        
        XCTAssertEqual(request.request.httpMethod, "GET")        
    }

}
