//
//  NewsRowView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import SwiftUI
import Kingfisher

struct NewsRowView: View {
  @State var new: Article
  var body: some View {
    HStack{
      VStack(alignment: .leading) {
        if new._title != "[Removed]"{
          Text(new._title)
            .font(.headline)
            .fontWeight(.bold)

          Text(new._newDescription)
            .font(.callout)
            .lineLimit(5)
        }
      }
      .frame(maxWidth: 200)

      Spacer()

      loadImage(new: new)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    .padding(.horizontal)
  }
}

extension NewsRowView {
  @ViewBuilder
  private func loadImage(new: Article) -> some View {
    if new._urlToImage != "Image url not found" {
      if let url = URL(string: new._urlToImage){
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
    NewsRowView(new: Article(source: Source(id: "1", name: "Sözcü"), author: "ben", title: "Sample titlejkasdaskdhasdkasd", newDescription: "ya işte kes sesini be kardeşimasdasdsa asdsa asdasasdsa sadas", url: "https://www.sofoot.com/breves/besiktas-se-separe-deric-bailly", urlToImage: "https://sofoot.s3.eu-central-1.amazonaws.com/wp-content/uploads/2023/12/29190602/6351534-hd-1400x1050.jpg", publishedAt: "2023-12-29T18:20:05Z", content: "Petits dépoussiérages de fin d'année. Manifestement insatisfaits du début de saison de leur équipe, malgré une cinquième place en championnat et un objectif européen toujours envisageable, les dirige… [+933 chars]"))
  }
}
