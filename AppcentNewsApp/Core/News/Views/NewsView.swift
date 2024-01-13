//
//  NewsView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import SwiftUI
import Combine
import Alamofire
import SwiftData

struct NewsView: View {
  @EnvironmentObject var newsViewModel: NewsViewModel
  @EnvironmentObject var favoritesViewModel: FavoritesViewModel
  var body: some View {
    ZStack{
      if newsViewModel.isLoading {
        ProgressView()
          .scaleEffect(2.0)
          .progressViewStyle(.circular)
          .tint(Color.theme.orangeColor)
          .zIndex(1)
      }
      VStack{
        Text("Appcent NewsApp")
          .foregroundStyle(Color.theme.accentColor)
          .font(.title)
          .fontWeight(.bold)
        SearchBarView(text: $newsViewModel.q, prompt: .constant("Type a text")) {
          newsViewModel.news.removeAll()
          newsViewModel.loadMoreContent()
        }
        List {
          ForEach(0..<newsViewModel.news.count, id: \.self) { index in
            NavigationLink {
              NewsDetailView(newsItem: newsViewModel.news[index])
                .environmentObject(newsViewModel)
                .environmentObject(favoritesViewModel)
            } label: {
              NewsRowView(news: newsViewModel.news[index])
                .onAppear {
                  if index + 1 == newsViewModel.news.count {
                    newsViewModel.loadMoreContent()
                  }
                }
            }
          }
        }
        .background(Color.theme.backgroundColor)
        .alert(isPresented: $newsViewModel.showAlert) {
          Alert(title: Text("Warning!"), message: Text(newsViewModel.alertMessage), dismissButton: .default(Text("OK")) {
            newsViewModel.showAlert = false
          })
        }
        .listStyle(.plain)
        .listRowSeparator(.visible)
      }
    }
  }
}

#Preview {
  NavigationStack{
    NewsView()
      .environmentObject(NewsViewModel(service: NewsService(networkManager: NetworkManager(reachabilityManager: NetworkReachabilityManager()!))))
      .environmentObject(FavoritesViewModel(userManager: UserManager(authManager: AuthManager())))
  }
}
