//
//  SignUpView.swift
//  AppcentNewsApp
//
//  Created by Oğuz Yıldırım on 11.01.2024.
//

import SwiftUI

import SwiftUI

struct SignUpView: View {
  @EnvironmentObject var signUpViewModel: SignUpViewModel
  @Binding var isUserSignUp: Bool
  var body: some View {
    VStack(spacing: 20){
      TextField("Username...", text: $signUpViewModel.userName)
        .padding()
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10))

      TextField("Email...", text: $signUpViewModel.email)
        .padding()
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10))

      SecureField("Password...", text: $signUpViewModel.password)
        .padding()
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10))

      SecureField("Password again...", text: $signUpViewModel.passwordIsCorrect)
        .padding()
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10))

      Button(action: {
        Task{
          do {
            try await signUpViewModel.signUp()
            isUserSignUp = false
          } catch {
            isUserSignUp = true
          }
        }
      }, label: {
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
      })

      Spacer()
    }
    .padding()
    .navigationTitle("Sign Up With Email")
    .alert(isPresented: $signUpViewModel.showAlert) {
      Alert(title: Text("Error"), message: Text(signUpViewModel.alertMessage), dismissButton: .default(Text("OK")))
    }
  }
}

#Preview {
  NavigationStack{
    SignUpView(isUserSignUp: .constant(false))
  }
}
