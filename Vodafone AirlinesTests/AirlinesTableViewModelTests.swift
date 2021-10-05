//
//  AirlinesTableViewModelTests.swift
//  Vodafone AirlinesTests
//
//  Created by Hassan Ashraf on 05/10/2021.
//

import XCTest
@testable import Vodafone_Airlines


class AirlinesTableViewModelTests: XCTestCase {
  
  var sut: AirlinesTableViewModel!
  var mockAPIService: MockAPIService!
  
  override func setUp() {
    super.setUp()
    mockAPIService = MockAPIService()
    sut = AirlinesTableViewModel(repo: mockAPIService)
  }
  
  override func tearDown() {
    sut = nil
    mockAPIService = nil
    super.tearDown()
  }
  
  func test_fetch_airline_list() {
    // When start fetch
    sut.fetchAirlinesData()
    
    // Assert
    XCTAssert(mockAPIService!.isFetchAirlinesListCalled)
  }
  
  
  func test_fetch_photo_fail() {
    
    // Given a failed fetch with a certain failure
    let errorMessage = "Something went wrong.."
    
    // When
    sut.fetchAirlinesData()
    
    mockAPIService.fetchFails(error: errorMessage)
    
    // Sut should display predefined error message
    XCTAssertEqual(sut.errorMessage, errorMessage)
    
  }
  
}

class MockAPIService: AirlinesListRepositoryProtocol {
  
  var airlinesList: [Airline] = [Airline]()
  var closure: ((Bool, [Airline], String?) -> ())!
  var isFetchAirlinesListCalled = false
  
  func fetchAirlinesData(complete: @escaping (Bool, [Airline], String?) -> ()) {
    isFetchAirlinesListCalled = true
    closure = complete
  }
  
  func fetchSuccess() {
    closure(true, airlinesList, nil)
  }
  
  func fetchFails(error: String) {
    closure(false, [Airline](), error)
  }
}
