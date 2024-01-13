//
//  Router.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
  case search(q: String, page: String, apiKey: String, pageSize: String)

  private var baseURL: URL {
    return URL(string: APIURLs.baseURL())!
  }

  private var apiKey: String {
    return APIURLs.apiKey()
  }

  private var method: HTTPMethod {
    return .get
  }

  private var path: String {
    switch self {
    case .search:
      return "/v2/everything"
    }
  }

  private var parameters: Parameters? {
    switch self {
    case .search(let q, let page, let api_key, let pageSize):
      return ["q" : q,
              "page" : page,
              "apiKey" : api_key,
              "pageSize" : pageSize
      ]
    }
  }

  func asURLRequest() throws -> URLRequest {
    let url = baseURL.appendingPathComponent(path)


    var request = URLRequest(url: url)
    request.method = method
    return try URLEncoding.default.encode(request, with: parameters)
  }
}
