//
//  SignUpViewModel.swift
//  myboost
//
//  Created by Mac-Mini-2021 on 14/03/2023.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPw = ""
    
    // MARK: - Validation Functions
    
    func passwordsMatch() -> Bool {
        password == confirmPw
    }
    
    func isPasswordValid() -> Bool {
        // criteria in regex.  See http://regexlib.com
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid() -> Bool {
        // criteria in regex.  See http://regexlib.com
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
    
   
    
    var isSignUpComplete: Bool {
        if !passwordsMatch() ||
        !isPasswordValid() ||
        !isEmailValid()  {
            return false
        }
        return true
    }
    
    // MARK: - Validation Prompt Strings
    
    var confirmPwPrompt: String {
        if passwordsMatch() {
            return ""
        } else {
            return "Password fields do not match"
        }
    }
    
    var emailPrompt: String {
        if isEmailValid() {
            return ""
        } else {
            return "Enter a valid email address"
        }
    }
    
    var passwordPrompt: String {
        if isPasswordValid() {
            return ""
        } else {
            return "Must be between 8 and 15 characters containing at least one number and one capital letter"
        }
    }
    
   
    
    func signUp() {
        // perform signup functions then clear fields
        email = ""
        password = ""
        confirmPw = ""
       
    }
}
