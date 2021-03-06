//
//  OnboardingLocalization.swift
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

class OnboardingLocalization {
    static let shared = OnboardingLocalization()
    
    private init() {
        
    }
    
    struct LocalizedKey {
        static let
        loginTitle = "Onboarding.scene.login.title",
        signUpTitle = "Onboarding.scene.sign.up.title"
    }
    
    let loginTitle = LocalizedKey.loginTitle.localized()
    let signUpTitle = LocalizedKey.signUpTitle.localized()
}
