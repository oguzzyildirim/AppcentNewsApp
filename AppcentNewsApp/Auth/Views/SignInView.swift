//
//  SignInView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import SwiftUI

struct SignInView: View {
  @EnvironmentObject var signInViewModel: SignInViewModel
  @Binding var isUserLogIn: Bool

  var body: some View {
    VStack(spacing: 20){
      TextField("Email...", text: $signInViewModel.email)
        .padding()
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10))

      SecureField("Password...", text: $signInViewModel.password, onCommit: {
        Task{
          do {
            try await signInViewModel.signIn()
            isUserLogIn = false
          } catch {
            isUserLogIn = true
          }
        }
      })
      .padding()
      .background(Color.gray.opacity(0.4))
      .clipShape(RoundedRectangle(cornerRadius: 10))

      Button(action: {
        Task{
          do {
            try await signInViewModel.signIn()
            isUserLogIn = false
          } catch {
            isUserLogIn = true
          }
        }
      }, label: {
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
      })

      Spacer()
    }
    .padding()
    .navigationTitle("Sign In With Email")
    .alert(isPresented: $signInViewModel.showAlert) {
      Alert(title: Text("Error"), message: Text(signInViewModel.alertMessage), dismissButton: .default(Text("OK")))
    }
  }
}

#Preview {
  NavigationStack{
    SignInView(isUserLogIn: .constant(false))
  }
}
