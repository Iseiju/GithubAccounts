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
                              completionHandler: @escaping (_ response: T) -> Void,
                              errorHandler: @escaping (_ error: NSError) -> Void) {
    AF.request(url, method: .get).responseData(completionHandler: { response in
      switch response.result {
      case .success(let data):
        let jsonDecoder = JSONDecoder()
        
        guard let object = try? jsonDecoder.decode(T.self, from: data) else {
          guard let errorResponse = try? jsonDecoder.decode(ErrorResponse.self, from: data) else {
            let jsonDecodeError = NSError(domain: "Iseiju.GithubAccounts",
                                          code: 400,
                                          userInfo: [NSLocalizedDescriptionKey: "JSON Decoding error"])
            return errorHandler(jsonDecodeError)
          }

          let nserror = NSError(domain: "Iseiju.GithubAccounts",
                                code: 403,
                                userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
          return errorHandler(nserror)
        }
        
        completionHandler(object)
        
      case .failure(let error as NSError):
        errorHandler(error)
      }
    })
  }
}
