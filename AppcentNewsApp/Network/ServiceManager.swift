//
//  ServiceManager.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import Foundation

protocol NewsServiceProtocol {
  func fetchSearch(q: String, page: String, apiKey: String, pageSize: String, completionHandler: @escaping (NewsViewModel.SearchedNewsResult) -> ())
}

final class NewsService: NewsServiceProtocol {
  //MARK: Dependency Injection
  let networkManager: NetworkManager

  init(networkManager: NetworkManager) {
    self.networkManager = networkManager
  }

  func fetchSearch(q: String, page: String, apiKey: String, pageSize: String, completionHandler: @escaping (NewsViewModel.SearchedNewsResult) -> ()) {
    DispatchQueue.global().async {
      self.networkManager.request(Router.search(q: q, page: page, apiKey: apiKey, pageSize: pageSize), decodeToType: NewsModel.self) { result in
        // Main thread
        DispatchQueue.main.async {
          completionHandler(result)
        }
      }
    }
  }
}
