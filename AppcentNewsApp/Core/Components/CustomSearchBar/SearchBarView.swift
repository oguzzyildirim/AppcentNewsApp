//
//  SearchBarView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 10.01.2024.
//

import SwiftUI

struct SearchBarView: View {
  @Binding var text: String
  @Binding var prompt: String
  var onCommit: () -> Void

  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundStyle(
          text.isEmpty ? Color.secondary : Color.theme.orangeColor
        )

      TextField(prompt, text: $text) {
        onCommit()
      }
      .foregroundStyle(Color.theme.accentColor)
      .overlay(
        Image(systemName: "xmark.circle.fill")
          .foregroundStyle(Color.theme.orangeColor)
          .padding()
          .offset(x: 10)
          .opacity(text.isEmpty ? 0.0 : 1.0)
          .onTapGesture {
            text = ""
          }
        , alignment: .trailing
      )
    }
    .font(.headline)
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 25)
        .fill(Color.theme.backgroundColor)
        .shadow(color: Color.theme.orangeColor.opacity(0.30), radius: 10)
    )
    .padding()
  }
}
