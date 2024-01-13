//
//  AuthView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import SwiftUI

struct AuthView: View {
  @EnvironmentObject var signUpViewModel: SignUpViewModel
  @EnvironmentObject var signInViewModel: SignInViewModel
  @Binding var isUserLogIn: Bool
    var body: some View {
      VStack(spacing: 20){
        NavigationLink {
          SignInView(isUserLogIn: $isUserLogIn)
            .environmentObject(signInViewModel)
        } label: {
          Text("Sign In")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(
              RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.theme.orangeColor)
            )
        }

        NavigationLink {
          SignUpView(isUserSignUp: $isUserLogIn)
            .environmentObject(signUpViewModel)
        } label: {
          Text("Sign Up With Email")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(
              RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.theme.orangeColor)
            )
        }

        Spacer()

      }
      .padding()
      .background(
        Color.theme.backgroundColor
      )
      .navigationTitle("Welcome to The App")
    }
}

#Preview {
    NavigationStack{
      AuthView(isUserLogIn: .constant(false))
    }
}
