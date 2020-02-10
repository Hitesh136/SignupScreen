//
//  UserViewModel.swift
//  CoolLoginScreens
//
//  Created by Hitesh Agarwal on 09/02/20.
//  Copyright © 2020 Hitesh Agarwal. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var userNameValidator = UsernameValidation.emptyUsername
    @Published var passwordValidator = PasswordValidation.empty
    @Published var isValid: Bool = false
    @Published var userNameError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    
    private var cancellableSet: Set<AnyCancellable> = []
    init() {
        Publishers.CombineLatest3(self.validUserNamePublisher, self.passwordValidatorPublisher, self.confirmPasswordValidatorPublisher)
            .dropFirst()
            .sink { _usernameError, _passwordValidator , _confirmPasswordValidator in
                
                self.isValid = _usernameError == nil &&
                    _passwordValidator.errorMessage == nil &&
                    _confirmPasswordValidator.confirmPasswordErrorMessage == nil
        }
        .store(in: &cancellableSet)
        
        validUserNamePublisher
        .dropFirst()
            .sink { (_usernameError) in
            self.userNameError = _usernameError
            }
        .store(in: &cancellableSet)
        
        passwordValidatorPublisher
            .dropFirst()
            .sink { (_passwordValidator) in
            self.passwordError = _passwordValidator.errorMessage
            }
            .store(in: &cancellableSet)
        
        confirmPasswordValidatorPublisher
                .dropFirst()
                   .sink { (_passwordValidator) in
                   self.confirmPasswordError = _passwordValidator.confirmPasswordErrorMessage
                   }
                   .store(in: &cancellableSet)
    }
    
    private var validUserNamePublisher: AnyPublisher<String?, Never> {
        
        $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { _username in
                if _username.isEmpty {
                    return "Please enter username"
                } else if !_username.isValidEmail {
                    return "Please enter valid email"
                } else {
                    return nil
                }
        }
        .eraseToAnyPublisher()
    }
    
    private var passwordValidatorPublisher: AnyPublisher<PasswordValidation, Never> {
        $password
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { password in
                if password.isEmpty {
                    return .empty
                } else {
                    return passwordStrengthChecker(forPassword: password)
                }
        }
        .eraseToAnyPublisher()
    }
    
    private var confirmPasswordValidatorPublisher: AnyPublisher<PasswordValidation, Never> {
        $confirmPassword
            .debounce(for: 0.0, scheduler: RunLoop.main)
            .map { confirmPassword in
                if confirmPassword.isEmpty {
                    return .confirmPasswordEmpty
                } else if self.password != confirmPassword {
                    return .notMatch
                } else {
                    return .reasonable
                }
        }
        .eraseToAnyPublisher()
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
