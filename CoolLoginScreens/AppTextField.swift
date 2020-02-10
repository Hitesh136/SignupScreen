//
//  AppTextField.swift
//  CoolLoginScreens
//
//  Created by Hitesh Agarwal on 08/02/20.
//  Copyright © 2020 Hitesh Agarwal. All rights reserved.
//

import SwiftUI

struct CrossButton: View {
    
    @Binding var contextText: String
    var body: some View {
        Button(action: {
            self.contextText = ""
        }) {
            
            ZStack(alignment: .center) {
                Circle()
                    .fill(redColor)
                    .frame(width: 18, height: 18)
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 8, height: 8)
                    .padding(.trailing, 1)
                    .font(Font.system(.title).bold())
                    .foregroundColor(.white)
            }
        }
    }
}

struct AppTextField: View {
    
    @Binding var contentText: String
    var placeHolder: String
    var isPasswordField: Bool
    var errorMessage: String?
//    @Binding var userNameValidator: UsernameValidation? = nil
//    @Binding var passwordValidator: PasswordValidation? = nil
    
//    var errorMessage: String? {
//        if let _userNameValidator = userNameValidator {
//            return _userNameValidator.errorMessage
//        } else if let _passwordValidator = passwordValidator {
//            return _passwordValidator.errorMessage
//        }
//    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(placeHolder)
                .foregroundColor(.white)
                .font(.headline)
                .opacity(0.5)
            
            HStack {
                
                if isPasswordField {
                    SecureField(placeHolder, text: $contentText)
                        .foregroundColor(.white)
                        .font(.headline)
                } else {
                    TextField(placeHolder, text: $contentText)
                        .foregroundColor(.white)
                        .font(.headline)
                        .autocapitalization(UITextAutocapitalizationType.none)
                }
                Spacer()
                
                if errorMessage != nil {
                    CrossButton(contextText: $contentText)
                }
            }
            
            Rectangle()
                .fill( errorMessage == nil ? .white : redColor)
                .frame(height: 1)
                .padding(.top, 0)
            
            Text(errorMessage ?? "")
                .foregroundColor(redColor)
                .font(.caption)
        }
        
    }
}
//
struct AppTextField_Previews: PreviewProvider {
    @State static var contentText: String = "Content Text"
    @State static var errorMessage1: String? = "Please enter conten"
    @State static var errorMessage2: String? = nil

    
    @State static var userNameValidator: UsernameValidation? = nil
    @State static var passwordValidator: PasswordValidation? = nil
    static var previews: some View {
        ZStack {
            Color.blue

            VStack {
                AppTextField(contentText: $contentText,
                             placeHolder: "Email",
                             isPasswordField: false,
                             errorMessage: errorMessage1)
//                             userNameValidator: userNameValidator)
                
                AppTextField(contentText: $contentText,
                             placeHolder: "Password",
                             isPasswordField: true,
                             errorMessage: errorMessage2)
                
                AppTextField(contentText: $contentText,
                             placeHolder: "Confirm Password",
                             isPasswordField: false,
                             errorMessage: errorMessage2)
//                AppTextField(contentText: $contentText,
//                             validationStatus: $validationStatus,
//                             placeHolder: "Email",
//                             isPasswordField: false)
                
//                AppTextField(contentText: $viewModel.password,
//                             validationStatus: $viewModel.validationStatus,
//                             placeHolder: "Password",
//                             isPasswordField: true)
//
//                AppTextField(contentText: $viewModel.confirmPassword,
//                             validationStatus: $viewModel.validationStatus,
//                             placeHolder: "Confirm Password",
//                             isPasswordField: false)

            }
        }
    }
}
