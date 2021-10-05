//
//  AddAirlineViewModelTests.swift
//  Vodafone AirlinesTests
//
//  Created by Hassan Ashraf on 05/10/2021.
//

import Foundation

import XCTest
@testable import Vodafone_Airlines


class AddAirlineViewModelTests: XCTestCase {
  
  var sut: AddAirlineViewModel!
  var mockAPIService: AddAirlineMockAPIService!
  
  override func setUp() {
    super.setUp()
    mockAPIService = AddAirlineMockAPIService()
    sut = AddAirlineViewModel(repo: mockAPIService)
  }
  
  override func tearDown() {
    sut = nil
    mockAPIService = nil
    super.tearDown()
  }
  
  //TODO: Test Validation on each input.
  func test_validation() {
    sut.airlineViewModel = AirlineViewModel()
    sut.airlineViewModel?.name = "Vodafone"
    sut.airlineViewModel?.address = "Smart Village"
    sut.airlineViewModel?.country = "Egypt"
    sut.airlineViewModel?.slogan = "Slogan.."
    sut.airlineViewModel?.website = "www.vodafone.com"
//    sut.validate()
    XCTAssertTrue(sut.validate())
  }
  
  func test_add_new_airline() {
    
    // When start fetch
    sut.airlineViewModel = AirlineViewModel()
    sut.addAirline()
    
    // Assert
    XCTAssert(mockAPIService!.isAddedSuccessfully)
  }
  
  
  func test_add_airline_fail() {
    
    // Given a failed fetch with a certain failure
    let errorMessage = "Something went wrong.."
    
    // When
    sut.airlineViewModel = AirlineViewModel()
    sut.addAirline()
    
    mockAPIService.addFails(error: errorMessage)
    
    // Sut should display predefined error message
    XCTAssertEqual(sut.errorMessage.value, errorMessage)
    
  }
  
}

class AddAirlineMockAPIService: AddAirlineRepositoryProtocol {
 
  var closure: ((Bool, String?) -> ())!
  var isAddedSuccessfully = false
  
  func AddAirline(airline: AirlineViewModel, complete: @escaping (Bool, String?) -> ()) {
    isAddedSuccessfully = true
    closure = complete
  }
  
  func addSuccess() {
    closure(true, nil)
  }
  
  func addFails(error: String) {
    closure(false, error)
  }
}
