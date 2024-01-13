//
//  NewsViewModels.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import Foundation
import SwiftUI

@MainActor
final class NewsViewModel: ObservableObject {
  typealias SearchedNewsResult = Result<NewsModel, Error>
  @Published var newsResult: SearchedNewsResult?
  @Published var news: [Article] = []
  @Published var showAlert: Bool = false
  @Published var isLoading: Bool = false
  @Published var q: String = ""
  @Published var alertMessage: String = ""
  @Published var page: Int
  @Published var totalPages: Int

  private var service: NewsServiceProtocol

  init(service: NewsServiceProtocol) {
    self.service = service
    page = 1
    totalPages = 2
  }

  //MARK: - PAGINATION
  func loadMoreContent() {
    // Actually, this 'if statement' gets executed during the user's initial search as well, but I ignore it since I invoke the 'loadMoreContent()' function with every search operation as well, outside the 'onAppear' block in 'NewsView'.
    if !self.isLoading && !q.isEmpty && page < totalPages {
      self.isLoading = true
      fetchNews()
    }
  }

  func fetchNews() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
      // fetchSearch function has pageSize parameter for ui optimization.
      self.service.fetchSearch(q: self.q, page: "\(self.page)", apiKey: APIURLs.apiKey(), pageSize: "\(6)") { [weak self] result in
        guard let self = self else { return }
        self.newsResult = result

        if let news = self.newsResult {
          switch news {
          case .success(let news):
            if let status = news.status {
              if status == "error" {
                alertMessage = "You have made too many requests recently. Developer accounts are limited to 100 requests over a 24 hour period (50 requests available every 12 hours)."
                showAlert = true
              }
              else if news._totalResults == 0 {
                alertMessage = "No news sources matching your searched word found."
                showAlert = true
              } else {
                self.totalPages = news._totalResults
                self.page += 1
                self.news.append(contentsOf: news._articles)
              }
            }
          case .failure(let failure):
            alertMessage = "Loading error"
            showAlert = true
            print("Error: \(failure)")
          }
        }
      }
    }
    self.isLoading = false
  }
}

