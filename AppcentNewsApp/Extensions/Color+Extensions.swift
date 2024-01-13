//
//  Color+Extensions.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import Foundation
import SwiftUI

extension Color {
  static let theme = ColorTheme()
}

struct ColorTheme {
  let accentColor = Color("AccentColorForViews")
  let backgroundColor = Color("BackgroundColor")
  let orangeColor = Color("AppcentOrangeColor")
  let secondaryTextColor = Color("SecondaryTextColor")
}
