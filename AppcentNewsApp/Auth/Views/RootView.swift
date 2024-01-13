//
//  RootView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import SwiftUI

struct RootView: View {
  @EnvironmentObject var viewModel: CustomTabViewModel
  @EnvironmentObject var newsViewModel: NewsViewModel
  @EnvironmentObject var signUpViewModel: SignUpViewModel
  @EnvironmentObject var signInViewModel: SignInViewModel
  @EnvironmentObject var settingsViewModel: SettingsViewModel
  @EnvironmentObject var favoritesViewModel: FavoritesViewModel

  @State private var isUserLogIn: Bool = true

  var authManager: AuthManager

  init(authManager: AuthManager) {
    self.authManager = authManager
  }

  var body: some View {
    ZStack{
      NavigationStack{
        MainPageView(isUserLogOut: $isUserLogIn)
          .environmentObject(viewModel)
          .environmentObject(newsViewModel)
          .environmentObject(settingsViewModel)
          .environmentObject(favoritesViewModel)
      }

    }
    .onAppear {
      Task {
        let authUser = try? await authManager.getAuthenticatedUser()
        self.isUserLogIn = authUser == nil
      }
    }
    .fullScreenCover(isPresented: $isUserLogIn, content: {
      NavigationStack{
        AuthView(isUserLogIn: $isUserLogIn)
          .environmentObject(signUpViewModel)
          .environmentObject(signInViewModel)
      }
    })
  }

}

#Preview {
  RootView(authManager: AuthManager())
}
