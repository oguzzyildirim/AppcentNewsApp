//
//  AppcentNewsAppApp.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import SwiftUI
import Alamofire
import SwiftData
import Firebase
import FirebaseFirestore


@main
struct AppcentNewsAppApp: App {
  @StateObject var customTabViewModel: CustomTabViewModel
  @StateObject var newsViewModel: NewsViewModel
  @StateObject var signUpViewModel: SignUpViewModel
  @StateObject var signInViewModel: SignInViewModel
  @StateObject var settingsViewModel: SettingsViewModel
  @StateObject var favoritesViewModel: FavoritesViewModel
  var authManager: AuthManager




  //MARK: Dependency Injection
  init() {
    FirebaseApp.configure()
    if let reachabilityManager = NetworkReachabilityManager() {
      let networkManager = NetworkManager(reachabilityManager: reachabilityManager)
      let newsService = NewsService(networkManager: networkManager)
      authManager = AuthManager()
      let userManager = UserManager(authManager: authManager)
      let authenticationManager = authManager
      _signUpViewModel = StateObject(wrappedValue: SignUpViewModel(authManager: authenticationManager, userManager: userManager))
      _signInViewModel = StateObject(wrappedValue: SignInViewModel(authManager: authenticationManager))
      _settingsViewModel = StateObject(wrappedValue: SettingsViewModel(authManager: authenticationManager))
      _customTabViewModel = StateObject(wrappedValue: CustomTabViewModel(newsService: newsService))
      _newsViewModel = StateObject(wrappedValue: NewsViewModel(service: newsService))
      _favoritesViewModel = StateObject(wrappedValue: FavoritesViewModel(userManager: userManager))
    } else {
      fatalError("Failed to initialize NetworkReachabilityManager")
    }
  }

  var body: some Scene {
    WindowGroup {
      NavigationStack{
        RootView(authManager: authManager)
          .environmentObject(customTabViewModel)
          .environmentObject(newsViewModel)
          .environmentObject(signUpViewModel)
          .environmentObject(signInViewModel)
          .environmentObject(settingsViewModel)
          .environmentObject(favoritesViewModel)
      }
    }
  }
}

