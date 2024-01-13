//
//  CustomTabView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 9.01.2024.
//

import SwiftUI

struct CustomTabView: View {
  @Binding var selectedTab: CustomTabEnum.Tab

  init(selectedTab: Binding<CustomTabEnum.Tab>) {
    self._selectedTab = selectedTab
  }

  private var fillImage: String {
    if selectedTab == .gear {
      return selectedTab.rawValue + ".circle.fill"
    }

    return selectedTab.rawValue + ".fill"

  }
  private var tabName: String {
    if selectedTab == .house {
      return "News"
    }
    else if selectedTab == .heart {
      return "Favorites"
    }
    else if selectedTab == .gear {
      return "Settings"
    }
    return ""
  }
  var body: some View {
    VStack {
      HStack(alignment: .bottom) {
        ForEach(CustomTabEnum.Tab.allCases, id: \.rawValue) { tab in
          Spacer()
          VStack(alignment: .center){
            Spacer()
            Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
              .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
              .foregroundStyle(selectedTab == tab ? Color.theme.orangeColor : Color.theme.secondaryTextColor)
              .font(.system(size: 22))
              .onTapGesture {
                withAnimation(.easeIn(duration: 0.1)) {
                  selectedTab = tab
                }
              }
              .padding(.top, 5)

            Text(selectedTab == tab ? tabName : "")
              .foregroundStyle(Color.white)
              .padding(.top, 5)

          }
          .frame(maxHeight: 35)

          Spacer()
        }

      }
      .padding()
      .background(Color.black.ignoresSafeArea())
      .shadow(color: Color.theme.orangeColor, radius: 5, x: 0, y: 0)
    }

  }
}

#Preview {
  CustomTabView(selectedTab: .constant(.house))
}

