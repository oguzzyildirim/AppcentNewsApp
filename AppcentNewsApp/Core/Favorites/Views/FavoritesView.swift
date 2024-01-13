//
//  FavoritesView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 12.01.2024.
//

import SwiftUI

struct FavoritesView: View {
  @EnvironmentObject var favoritesViewModel: FavoritesViewModel
  var body: some View {
    VStack{
      Text("Favorites")
        .foregroundStyle(Color.theme.accentColor)
        .font(.title)
        .fontWeight(.bold)
      List{
        ForEach(favoritesViewModel.favorites) { favorite in
          NavigationLink {
            NewsDetailView(newsItem: favorite.favorite)
              .environmentObject(favoritesViewModel)
          } label: {
            NewsRowView(news: favorite.favorite)
          }
        }
        .onDelete(perform: { indexSet in
          Task {
            for index in indexSet {
              let favoriteToDelete = favoritesViewModel.favorites[index]
              do {
                try await favoritesViewModel.deleteFavoriteFromFavorites(favorite: favoriteToDelete.favorite)
                favoritesViewModel.favorites.remove(at: index)
              } catch {
                print("Error: \(error)")
              }
            }
          }
        })
      }
      .background(Color.theme.backgroundColor)
      .listStyle(.plain)
      .listRowSeparator(.visible)
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          Task {
            favoritesViewModel.favorites.removeAll()
            try await favoritesViewModel.loadFavorites()
          }
        }
      }
    }
  }
}

#Preview {
  FavoritesView()
    .environmentObject(FavoritesViewModel(userManager: UserManager(authManager: AuthManager())))
}
