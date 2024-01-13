//
//  NewsManager.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
  var reachabilityManager: NetworkReachabilityManager { get }

  init(reachabilityManager: NetworkReachabilityManager)

  func isConnectedToInternet() -> Bool

  func request<T: Codable>(_ request: URLRequestConvertible,
                           decodeToType type: T.Type,
                           completionHandler: @escaping (Result<T,Error>) -> ())
}


final class NetworkManager: NetworkManagerProtocol {

  let reachabilityManager: NetworkReachabilityManager

  init(reachabilityManager: NetworkReachabilityManager) {
    self.reachabilityManager = reachabilityManager
  }

  func isConnectedToInternet() -> Bool {
    return reachabilityManager.isReachable
  }

  func request<T: Codable>(_ request: URLRequestConvertible,
                           decodeToType type: T.Type,
                           completionHandler: @escaping (Result<T,Error>) -> ()) {
    AF.request(request).responseData { response in

      switch response.result {

      case .success(let data):
        do {
          let decoder = JSONDecoder()
          let result = try decoder.decode(type.self, from: data)
          completionHandler(.success(result))
        } catch {
          completionHandler(.failure(error))
        }
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
}
