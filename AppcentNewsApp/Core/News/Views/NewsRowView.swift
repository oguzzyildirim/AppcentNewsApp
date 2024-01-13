//
//  NewsRowView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import SwiftUI
import Kingfisher

struct NewsRowView: View {
  @State var news: Article
  var body: some View {
    HStack{
      VStack(alignment: .leading) {
        if news._title != "[Removed]"{
          Text(news._title)
            .font(.headline)
            .fontWeight(.bold)

          Text(news._newsDescription)
            .font(.callout)
            .lineLimit(5)
        }
      }
      .frame(maxWidth: 200)

      Spacer()

      loadImage(news: news)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    .padding(.horizontal)
  }
}

extension NewsRowView {
  @ViewBuilder
  private func loadImage(news: Article) -> some View {
    if news._urlToImage != "Image url not found" {
      if let url = URL(string: news._urlToImage){
        KFImage(url)
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 70)
      }
    } else {
      ProgressView()
        .frame(width: 100, height: 50)
    }
  }
}

#Preview {
  NavigationStack {
    NewsRowView(news: Article(source: Source(id: "1", name: "Sözcü"), author: "ben", title: "Sample titlejkasdaskdhasdkasd", newsDescription: "ya işte kes sesini be kardeşimasdasdsa asdsa asdasasdsa sadas", url: "https://www.sofoot.com/breves/besiktas-se-separe-deric-bailly", urlToImage: "https://sofoot.s3.eu-central-1.amazonaws.com/wp-content/uploads/2023/12/29190602/6351534-hd-1400x1050.jpg", publishedAt: "2023-12-29T18:20:05Z", content: "Petits dépoussiérages de fin d'année. Manifestement insatisfaits du début de saison de leur équipe, malgré une cinquième place en championnat et un objectif européen toujours envisageable, les dirige… [+933 chars]"))
  }
}
