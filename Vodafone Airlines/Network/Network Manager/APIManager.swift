//
//  APIManager.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation
import Alamofire

class APIManager {
  
  private let sessionManager: Session
  static let networkEnvironment: NetworkEnvironment = .dev

  private static var sharedApiManager: APIManager = {
    let apiManager = APIManager(sessionManager: Session())
    return apiManager
  }()
  
  class func shared() -> APIManager {
    return sharedApiManager
  }
  
  private init(sessionManager: Session) {
    self.sessionManager = sessionManager
  }
  
  func request<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (T?, _ error: String?) -> ()) where T: Codable {
    self.sessionManager.request(type.url,
                                method: type.httpMethod,
                                parameters: params,
                                encoding: type.encoding,
                                headers: type.headers
    ).validate().responseJSON { (data) in
      switch data.result {
      case .success(_):
        let decoder = JSONDecoder()
        if let jsonData = data.data {
          let result = try! decoder.decode(T.self, from: jsonData)
          handler(result, nil)
        }
        break
      case .failure(let error):
        handler(nil, error.localizedDescription)
        break
      }
    }
  }
}
