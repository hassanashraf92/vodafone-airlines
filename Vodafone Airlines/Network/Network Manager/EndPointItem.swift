//
//  EndPointItem.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation
import Alamofire

enum NetworkEnvironment {
  case dev
}

enum EndPointItem {
  //MARK: End Point Items
  //Here goes all the end points we are going to use..
  case getAirlinesList
  case addNewAirline
  
}

//MARK: Then we confirm to the protocol we are going to use..
extension EndPointItem: EndPointType {


  var baseURL: String {
    switch self {
    case .getAirlinesList, .addNewAirline:
      return "https://6159b114601e6f0017e5a2b6.mockapi.io/"
    }
  }
  
  var version: String {
    switch self {
    default:
      return ""
    }
  }
  
  var path: String {
    switch self {
    case .getAirlinesList, .addNewAirline:
      return "airlines"
    }
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .addNewAirline:
      return .post
    default:
      return .get
    }
  }


  var headers: HTTPHeaders {
    switch self {
      default:
        return ["Accept": "application/json"]
      }
  }
  
  var url: URL {
    switch self {
    default:
      return URL(string: self.baseURL + self.version + self.path)!
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    default:
      return JSONEncoding.default
    }
  }

}
