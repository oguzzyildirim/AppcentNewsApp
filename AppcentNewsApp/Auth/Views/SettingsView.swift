//
//  SettingsView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var settingsViewModel: SettingsViewModel
  @Binding var isUserLogOut: Bool
  @State private var showAlert = false
  @State private var alertMessage: String = ""

  var body: some View {
    VStack{
      Text("Settings")
        .foregroundStyle(Color.theme.accentColor)
        .font(.title)
        .fontWeight(.bold)
      List{
        Button("Log out") {
          Task {
            do {
              try settingsViewModel.signOut()
              isUserLogOut = true
            } catch {
              print("Error while sign out: \(error)")
            }
          }
        }
      }
    }
  }
}

#Preview {
  NavigationStack{
    SettingsView(isUserLogOut: .constant(false))
  }
}
