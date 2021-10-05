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
    sut.airlineName = "New Airline"
    sut.airlineCountry = "Egypt"
    sut.airlineSlogan = "Not really.."
    sut.airlineAddress = "13/2 Hassan Nassar"
    sut.airlineWebsite = "www.vodafone.com"
    XCTAssert(sut.validate())
  }
  
  func test_validation_fails() {
    sut.airlineName = "New Airline"
    sut.airlineCountry = "Egypt"
    sut.airlineSlogan = "Not really.."
    sut.airlineAddress = "13/2 Hassan Nassar"
    sut.airlineWebsite = ""
    XCTAssertEqual(sut.validate(), false)
  }
  
  func test_add_new_airline() {
    // When start fetch
    sut.addAirline()
    
    // Assert
    XCTAssert(mockAPIService!.isAddedSuccessfully)
  }
  
  
  func test_add_airline_fail() {
    
    // Given a failed fetch with a certain failure
    let errorMessage = "Something went wrong.."
    
    // When
    sut.addAirline()
    
    mockAPIService.addFails(error: errorMessage)
    
    // Sut should display predefined error message
    XCTAssertEqual(sut.errorMessage.value, errorMessage)
    
  }
  
}

class AddAirlineMockAPIService: AddAirlineRepositoryProtocol {
  
  var closure: ((Bool, String?) -> ())!
  var isAddedSuccessfully = false
  
  func AddAirline(name: String, slogan: String, country: String, headquarter: String, website: String, complete: @escaping (Bool, String?) -> ()) {
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
