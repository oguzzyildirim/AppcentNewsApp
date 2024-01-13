//
//  NewsDetailView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import SwiftUI
import Kingfisher
import Alamofire
import SwiftData
import WebKit

struct NewsDetailView: View {
  var new: Article
  @EnvironmentObject var newsViewModel: NewsViewModel
  @EnvironmentObject var favoritesViewModel: FavoritesViewModel

  init(newItem: Article) {
    new = newItem
  }
  var body: some View {
    ZStack{
      ScrollView {
        VStack(alignment: .center, spacing: 30){
          loadImage(new: new)
            .clipShape(RoundedRectangle(cornerRadius: 10))

          VStack(alignment: .leading){
            Text(new._newDescription)
              .font(.headline)
              .fontWeight(.bold)
              .foregroundStyle(Color.theme.accentColor)
            HStack(alignment: .center){
              Spacer()
              Image(systemName: "book.pages")
                .resizable()
                .frame(width: 30, height: 30)
              Text(new._author)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.theme.accentColor)
              Spacer()
              Image(systemName: "calendar")
                .resizable()
                .frame(width: 30, height: 30)
              Text(DateFormatter.convertDateStringToDate(new._publishedAt))
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.theme.accentColor)
              Spacer()
            }

          }
          .padding(.horizontal, 5)

          Text(new._content.removeAfterCharacter("["))
            .font(.callout)
            .foregroundStyle(Color.theme.accentColor)

        }
        .padding()
      }
      VStack {
        Spacer()
        HStack(alignment: .bottom){
          Spacer()

          NavigationLink {
            WebView(url: new._url)
              .navigationTitle("New Source")
              .navigationBarTitleDisplayMode(.inline)
          } label: {
            Spacer()
            navigationLinklabel
              .padding()
            Spacer()
          }

        }
        .frame(maxWidth: .infinity)
        .background(Color.theme.backgroundColor)
      }
    }
    .toolbar{
      ToolbarItem(placement: .topBarTrailing) {
        HStack{
          if new._url != "Url not found" {
            let url = URL(string: new._url)!
            ShareLink(item: url, subject: Text("Check out this link"), message: Text("If you want to learn Swift, take a look at this website.")) {
              Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
                .foregroundStyle(Color.theme.accentColor)
            }

          }
          Button {
            Task {
              do {
                try await favoritesViewModel.loadFavorites()
                let favorite = DBFavorite(favorite: new)
                if !favoritesViewModel.doesFavoriteExist(favoriteIsExist: favorite){
                  try await favoritesViewModel.userManager.createNewFavorite(favorite: favorite)
                } else {
                  try await favoritesViewModel.deleteFavoriteFromFirestore(favorite: new)
                }
              } catch {
                throw URLError(.badServerResponse)
              }
            }
          } label: {
            Image(systemName: "heart.fill")
              .resizable()
              .scaledToFit()
              .frame(width: 30, height: 30)
              .padding()
              .foregroundStyle(Color.theme.accentColor)
          }
          .alert(isPresented: $favoritesViewModel.showAlert) {
            Alert(
              title: Text(favoritesViewModel.alertMessage),
              dismissButton: .default(Text("Okay")) {
                favoritesViewModel.showAlert = false
              }
            )
          }
        }
      }
    }
  }
}

extension NewsDetailView {
  @ViewBuilder
  private func loadImage(new: Article) -> some View {
    if new._urlToImage != "Image url not found" {
      if let url = URL(string: new._urlToImage){
        KFImage(url)
          .resizable()
          .scaledToFill()
          .frame(width: 370, height: 250)

      }
    } else {
      ProgressView()
        .frame(width: 100, height: 50)
    }
  }

  private var navigationLinklabel: some View {
    Text("New Source")
      .font(.headline)
      .fontWeight(.bold)
      .foregroundStyle(Color.white)
      .frame(height: 55)
      .frame(maxWidth: 250)
      .background(
        RoundedRectangle(cornerRadius: 15)
          .foregroundStyle(Color.theme.orangeColor)
      )
      .shadow(color: Color.theme.backgroundColor.opacity(0.60), radius: 10, x: 0.0, y: 0.0)
      .background(Color.theme.backgroundColor)
  }
}


#Preview {
  NavigationStack{
    NewsDetailView(newItem: Article(source: Source(id: "1", name: "Sözcü"), author: "ben", title: "Sample titlejkasdaskdhasdkasd", newDescription: "Petits dépoussiérages de fin d'année. Manifestement insatisfaits du début de saison de leur équipe.", url: "https://www.sofoot.com/breves/besiktas-se-separe-deric-bailly", urlToImage: "https://sofoot.s3.eu-central-1.amazonaws.com/wp-content/uploads/2023/12/29190602/6351534-hd-1400x1050.jpg", publishedAt: "2023-12-29T18:20:05Z", content: "Petits dépoussiérages de fin d'année. Manifestement insatisfaits du début de saison de leur équipe, malgré une cinquième place en championnat et un objectif européen toujours envisageable, les dirige jdksfkslf ajksdhaskl dkajsdhksad kjashdjkasdh kjashdkjashd kjashdjkash kjashdkjsahd kjashdkjashdkj kajsdhkjsahdkjsahdkjsahdjksah"))
      .environmentObject(NewsViewModel(service: NewService(networkManager: NetworkManager(reachabilityManager: NetworkReachabilityManager()!))))
      .environmentObject(FavoritesViewModel(userManager: UserManager(authManager: AuthManager())))
  }
}
