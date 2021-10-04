//
//  EndPointTypeProtocol.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation
import Alamofire

protocol EndPointType {
  
  var baseURL: String { get }
  var path: String { get }
  var httpMethod: HTTPMethod { get }
  var headers: HTTPHeaders { get }
  var url: URL { get }
  var encoding: ParameterEncoding { get }
  var version: String { get }
  
}

