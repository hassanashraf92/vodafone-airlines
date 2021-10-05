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
  
  
  func test_fetch_airlines_fail() {
    
    // Given a failed fetch with a certain failure
    let errorMessage = "Something went wrong.."
    
    // When
    sut.fetchAirlinesData()
    
    mockAPIService.fetchFails(error: errorMessage)
    
    // Sut should display predefined error message
    XCTAssertEqual(sut.errorMessage, errorMessage)
    
  }
  
  func test_create_cell_view_model() {
    // Given
    let airlinesResponse = StubGenerator().stubAirlines()
    mockAPIService.airlinesList = airlinesResponse
    
    // When
    sut.fetchAirlinesData()
    mockAPIService.fetchSuccess()
    
    // Number of cell view model is equal to the number of ailines
    XCTAssertEqual(sut.airlineViewModels.value?.count, airlinesResponse.count)
  }
  
}

class MockAPIService: AirlinesListRepositoryProtocol {
  
  var airlinesList: [AirlineResponse] = [AirlineResponse]()
  var closure: ((Bool, [AirlineResponse], String?) -> ())!
  var isFetchAirlinesListCalled = false
  
  func fetchAirlinesData(complete: @escaping (Bool, [AirlineResponse], String?) -> ()) {
    isFetchAirlinesListCalled = true
    closure = complete
  }
  
  func fetchSuccess() {
    closure(true, airlinesList, nil)
  }
  
  func fetchFails(error: String) {
    closure(false, [AirlineResponse](), error)
  }
}


class StubGenerator {
  func stubAirlines() -> [AirlineResponse] {
    let path = Bundle.main.path(forResource: "airlines", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path))
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let airlines = try! decoder.decode([AirlineResponse].self, from: data)
    return airlines
  }
}
