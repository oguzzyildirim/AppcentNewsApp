//
//  NewModel.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import Foundation

// MARK: - NewModel
struct NewModel: Codable, Identifiable {
  var id: String {return UUID().uuidString }
  let status: String?
  let totalResults: Int?
  let articles: [Article]?

  var _totalResults: Int {
    totalResults ?? 1
  }

  var _articles: [Article] {
    articles ?? []
  }
}

// MARK: - Article
struct Article: Codable, Identifiable {
  var id: String {return UUID().uuidString }
  let source: Source?
  let author: String?
  let title, newDescription: String?
  let url: String?
  let urlToImage: String?
  let publishedAt: String?
  let content: String?

  enum CodingKeys: String, CodingKey {
    case source = "source"
    case author = "author"
    case title = "title"
    case newDescription = "description"
    case url = "url"
    case urlToImage = "urlToImage"
    case publishedAt = "publishedAt"
    case content = "content"
  }

  var _source: Source {
    source ?? Source(id: "404", name: "Not Found")
  }

  var _author: String {
    author ?? "Author not found"
  }

  var _title: String {
    title ?? "Title not found"
  }
  var _newDescription: String {
    newDescription ?? "Description not found"
  }

  var _url: String {
    url ?? "Url not found"
  }

  var _urlToImage: String {
    urlToImage ?? "Image url not found"
  }
  var _publishedAt: String {
    publishedAt ?? "Date not found"
  }

  var _content: String {
    content ?? "Content not found"
  }
}

// MARK: - Source
struct Source: Codable, Identifiable {
  let id: String?
  let name: String?
}

extension Article {
  func dictionaryRepresentation() -> [String: Any] {
    return [
      "source": _source,
      "author": _author,
      "title": _title,
      "description": _newDescription,
      "url": _url,
      "urlToImage": _urlToImage,
      "publishedAt": _publishedAt,
      "content": _content
    ]
  }
}

