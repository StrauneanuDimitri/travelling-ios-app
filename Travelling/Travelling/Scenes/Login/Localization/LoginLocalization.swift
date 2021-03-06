//
//  LoginLocalization.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 04/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class LoginLocalization {
    static let shared = LoginLocalization()
    
    private init() {
        
    }
    
    struct LocalizedKey {
        static let
        loginTitle = "Login.scene.title",
        emailOrUsernameTitle = "Login.scene.email.or.username.title",
        passwordTitle = "Login.scene.password.title",
        
        emailOrUsernamePlaceholder = "Login.scene.email.or.username.placeholder",
        passwordPlaceholder = "Login.scene.password.placeholder",
        
        emailOrUsernameErrorText = "Login.scene.email.or.username.error.text",
        passwordErrorText = "Login.scene.password.error.text",
        
        forgotPasswordButtonTitle = "Login.scene.forgot.password.button.title",
        loginButtonTitle = "Login.scene.button.title",
        errorMessage = "Login.scene.generic.error.message",
        cancelTitle = "Login.scene.cancel.title",
        okTitle = "Login.scene.ok.title"
    }
    
    let loginTitle = LocalizedKey.loginTitle.localized()
    
    let emailOrUsernameTitle = LocalizedKey.emailOrUsernameTitle.localized()
    let passwordTitle = LocalizedKey.passwordTitle.localized()
    let emailOrUsernamePlaceholder = LocalizedKey.emailOrUsernamePlaceholder.localized()
    let passwordPlaceholder = LocalizedKey.passwordPlaceholder.localized()
    
    let emailOrUsernameErrorText = LocalizedKey.emailOrUsernameErrorText.localized()
    let passwordErrorText = LocalizedKey.passwordErrorText.localized()
    let forgotPasswordButtonTitle = LocalizedKey.forgotPasswordButtonTitle.localized()
    
    let loginButtonTitle = LocalizedKey.loginButtonTitle.localized()
    
    let errorMessage = LocalizedKey.errorMessage.localized()
    let cancelTitle = LocalizedKey.cancelTitle.localized()
    let okTitle = LocalizedKey.okTitle.localized()
}
