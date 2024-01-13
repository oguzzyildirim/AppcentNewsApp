//
//  ContentView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import SwiftUI
import Alamofire

struct MainPageView: View {
  @EnvironmentObject var viewModel: CustomTabViewModel
  @EnvironmentObject var newsViewModel: NewsViewModel
  @EnvironmentObject var settingsViewModel: SettingsViewModel
  @EnvironmentObject var favoritesViewModel: FavoritesViewModel
  @Binding var isUserLogOut: Bool
  var body: some View {
    ZStack{
      VStack{
        TabView(selection: $viewModel.selectedTab,
                content:  {
          switch viewModel.selectedTab {
          case .house:
            NewsView()
              .environmentObject(newsViewModel)
              .environmentObject(favoritesViewModel)
          case .heart:
            FavoritesView()
              .environmentObject(favoritesViewModel)
          case .gear:
            SettingsView(isUserLogOut: $isUserLogOut)
              .environmentObject(settingsViewModel)
          }
        })
      }
      VStack {
        Spacer()
        CustomTabView(selectedTab: $viewModel.selectedTab)
          .ignoresSafeArea()
      }
    }
    .onAppear {
      UITabBar.appearance().isHidden = true
    }
  }
}

#Preview {
  MainPageView(isUserLogOut: .constant(false))
    .environmentObject(CustomTabViewModel(newService: NewService(networkManager: NetworkManager(reachabilityManager: NetworkReachabilityManager()!))))
    .environmentObject(NewsViewModel(service: NewService(networkManager: NetworkManager(reachabilityManager: NetworkReachabilityManager()!))))
    .environmentObject(SettingsViewModel(authManager: AuthManager()))
    .environmentObject(FavoritesViewModel(userManager: UserManager(authManager: AuthManager())))
}
