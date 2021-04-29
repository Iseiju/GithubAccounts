//
//  APIClient.swift
//  GithubAccounts
//
//  Created by Kenneth James Uy on 4/29/21.
//

import Alamofire
import Foundation

class APIClient {
  
  static let shared: APIClient = { return APIClient() }()
  
  func getRequest<T: Codable>(_ url: String,
                              model: T.Type,
                              completion: @escaping (_ response: DataResponse<T, AFError>) -> Void) {
    AF.request(url, method: .get).responseDecodable(of: model, completionHandler: completion)
  }
}
