//
//  NewsViewModel_Tests.swift
//  AppcentNewsAppTests
//
//  Created by Oğuz Yıldırım on 12.01.2024.
//

import XCTest
import Alamofire
@testable import AppcentNewsApp

@MainActor
final class NewsViewModel_Tests: XCTestCase {
  var reachabilityManager: NetworkReachabilityManager!
  var networkManager: NetworkManager!
  var serviceManager: NewService!
  var newsViewModel: NewsViewModel!

  override func setUpWithError() throws {
    super.setUp()
    reachabilityManager = NetworkReachabilityManager()
    networkManager = NetworkManager(reachabilityManager: reachabilityManager)
    newsViewModel = NewsViewModel(service: NewService(networkManager: networkManager))
  }

  override func tearDownWithError() throws {
    reachabilityManager = nil
    networkManager = nil
    serviceManager = nil
    newsViewModel = nil
    super.tearDown()
  }

  func test_NewsViewModel_isLoading_shouldBeFalse(){
    // Given
    newsViewModel.page = 1
    newsViewModel.totalPages = 2
    newsViewModel.q = ""

    // When
    newsViewModel.loadMoreContent()

    // Then
    XCTAssertFalse(newsViewModel.isLoading)

  }

  func test_NewsViewModel_showAlert_shouldBeFalseWithValidParams() {
    // Given
    newsViewModel.isLoading = false
    newsViewModel.page = 1
    newsViewModel.totalPages = 2
    newsViewModel.q = "besiktas"

    // When
    newsViewModel.fetchNews()

    // Then
    XCTAssertFalse(newsViewModel.showAlert)

  }
}
