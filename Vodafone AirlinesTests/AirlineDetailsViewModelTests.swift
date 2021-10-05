//
//  AirlineDetailsViewModelTests.swift
//  Vodafone AirlinesTests
//
//  Created by Hassan Ashraf on 05/10/2021.
//

import XCTest
@testable import Vodafone_Airlines

class AirlineDetailsViewModelTests: XCTestCase {
  
  var sut: AirlineDetailsViewModel!
  var airline: AirlineViewModel!
  
  override func setUp() {
    super.setUp()
    airline = AirlineViewModel()
    sut = AirlineDetailsViewModel(airline)
  }
  
  override func tearDown() {
    sut = nil
    airline = nil
    super.tearDown()
  }
  
  func test_should_open_website() {
    sut.airline.website = "www.vodafone.com"
    sut.didPressVisit()
    XCTAssertEqual(sut.shouldOpenWebsite?.value, true)
  }
  
  func test_should_not_open_website() {
    sut.airline.website = ""
    sut.didPressVisit()
    XCTAssertEqual(sut.shouldOpenWebsite?.value, false)
  }
  
}
