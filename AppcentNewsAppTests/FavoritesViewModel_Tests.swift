//
//  FavoritesViewModel_Tests.swift
//  AppcentNewsAppTests
//
//  Created by Oğuz Yıldırım on 12.01.2024.
//

import XCTest
import Firebase
@testable import AppcentNewsApp

@MainActor
final class FavoritesViewModel_Tests: XCTestCase {
  var favoritesViewModel: FavoritesViewModel!
  var authManager: AuthManager!
  var userManager: UserManager!
  var news: Article!

  override func setUpWithError() throws {
    super.setUp()
    authManager = AuthManager()
    userManager = UserManager(authManager: authManager)
    favoritesViewModel = FavoritesViewModel(userManager: userManager)
    news = Article(source: Source(id: "1", name: "test_source"), author: "test_author", title: "test_title", newsDescription: "test_desc", url: "test_url", urlToImage: "test_urlToImage", publishedAt: "test_date", content: "test_content")
  }

  override func tearDownWithError() throws {
    userManager = nil
    authManager = nil
    favoritesViewModel = nil
    news = nil
    super.tearDown()
  }

  func test_FavoritesViewModel_doesFavoriteExist_shouldBeFalse() {
    // Given
    let favoriteIsExist = DBFavorite(favorite: news)
    favoritesViewModel.favorites = []

    // When
    let result = favoritesViewModel.doesFavoriteExist(favoriteIsExist: favoriteIsExist)

    // Then
    XCTAssertFalse(result, "Should return false when favorites list is empty")
  }


  func test_FavoritesViewModel_doesFavoriteExist_shouldBeTrue() {
    // Given
    let favoriteIsExist = DBFavorite(favorite: news)
    favoritesViewModel.favorites.append(favoriteIsExist) // Boş favoriler listesi

    // When
    let result = favoritesViewModel.doesFavoriteExist(favoriteIsExist: favoriteIsExist)

    // Then
    XCTAssertTrue(result, "Should return true when favorites list is not empty")
  }

  func test_FavoritesViewModel_alertMessage_shouldBeAdded() {
    // Given
    let favoriteIsExist = DBFavorite(favorite: news)
    favoritesViewModel.favorites = [] // Boş favoriler listesi

    // When
    let _ = favoritesViewModel.doesFavoriteExist(favoriteIsExist: favoriteIsExist)

    // Then
    XCTAssertEqual(favoritesViewModel.alertMessage, "Added to favorites.", "Alert message should be 'Added to favorites.'")
  }

  func test_FavoritesViewModel_alertMessage_shouldBeRemoved() {
    // Given
    let favoriteIsExist = DBFavorite(favorite: news)
    favoritesViewModel.favorites.append(favoriteIsExist)

    // When
    let _ = favoritesViewModel.doesFavoriteExist(favoriteIsExist: favoriteIsExist)

    // Then
    XCTAssertEqual(favoritesViewModel.alertMessage, "The article is already in your favorites. It has been removed.", "Alert message should be 'The article is already in your favorites. It has been removed.'")
  }

  func test_FavoritesViewModel_showAlert_shouldBeTrue() {
    // Given
    let favoriteIsExist = DBFavorite(favorite: news)
    favoritesViewModel.favorites.append(favoriteIsExist)

    // When
    let _ = favoritesViewModel.doesFavoriteExist(favoriteIsExist: favoriteIsExist)

    // Then
    XCTAssertTrue(favoritesViewModel.showAlert, "Should return true when favorites list is not empty")
  }

  func test_FavoritesViewModel_doesExist_shouldBeTrue() {
    // Given
    let favoriteIsExist = DBFavorite(favorite: news)
    favoritesViewModel.favorites.append(favoriteIsExist)

    // When
    let _ = favoritesViewModel.doesFavoriteExist(favoriteIsExist: favoriteIsExist)

    // Then
    XCTAssertTrue(favoritesViewModel.doesExist, "Should return true when favorites list is not empty")
  }

}
