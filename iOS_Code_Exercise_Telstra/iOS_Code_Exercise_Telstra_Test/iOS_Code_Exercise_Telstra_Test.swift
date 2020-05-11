//
//  iOS_Code_Exercise_Telstra_Test.swift
//  iOS_Code_Exercise_Telstra_Test
//
//  Created by ANUJ KUMAR on 11/05/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import XCTest

class iOS_Code_Exercise_Telstra_Test: XCTestCase {
    var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetListSuccessReturn() {
        let expectation = XCTestExpectation(description: "Checking for success response")
        Service.shared.getFacts { (list,error) in
            if list != nil
            {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
