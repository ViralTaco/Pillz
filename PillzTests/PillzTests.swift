//
//  PillzTests.swift
//  PillzTests
//
//  Created by viraltaco_ on 20200215.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation
import XCTest
@testable import Pillz

class PillzTests: XCTestCase {
  var testDir: URL? = nil
  
  override func setUp() {
    self.testDir = Defaults.folder(name: "PillzTest")
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
