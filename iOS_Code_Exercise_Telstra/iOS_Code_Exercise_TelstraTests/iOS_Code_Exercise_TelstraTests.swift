//
//  iOS_Code_Exercise_TelstraTests.swift
//  iOS_Code_Exercise_TelstraTests
//
//  Created by ANUJ KUMAR on 03/05/20.
//  Copyright © 2020 ANUJ KUMAR. All rights reserved.
//

import XCTest
@testable import iOS_Code_Exercise_Telstra


class iOS_Code_Exercise_TelstraTests: XCTestCase {
 var dut: URLSession!
   override func setUp() {
     super.setUp()
     dut = URLSession(configuration: .default)
   }
   
   override func tearDown() {
     dut = nil
     super.tearDown()
   }
    // Asynchronous test: success fast, failure slow
    func testValidCallTofetchDescAPIHTTPStatusCode200() {
      // given
      let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
      // 1
      let promise = expectation(description: "Status code: 200")
      
      // when
      let dataTask = dut.dataTask(with: url!) { data, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }
    
    // Asynchronous test: faster fail
     func testCallTofetchDescAPI() {
       // given
       let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
       // 1
       let promise = expectation(description: "Completion handler invoked")
       var statusCode: Int?
       var responseError: Error?
       
       // when
       let dataTask = dut.dataTask(with: url!) { data, response, error in
         statusCode = (response as? HTTPURLResponse)?.statusCode
         responseError = error
         // 2
         promise.fulfill()
       }
       dataTask.resume()
       // 3
       wait(for: [promise], timeout: 5)
       
       // then
       XCTAssertNil(responseError)
       XCTAssertEqual(statusCode, 200)
     }
}
