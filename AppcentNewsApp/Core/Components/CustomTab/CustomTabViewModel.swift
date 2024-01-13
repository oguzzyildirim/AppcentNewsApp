//
//  CustomTabViewModel.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import Foundation

final class CustomTabViewModel: ObservableObject {
  private var newsService: NewsServiceProtocol

  init(newsService: NewsServiceProtocol) {
    self.newsService = newsService
  }
  @Published var selectedTab: CustomTabEnum.Tab = .house
}
