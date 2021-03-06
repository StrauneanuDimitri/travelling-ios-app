//
//  MyProfilePresentationLogicSpy.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 27/09/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling

class MyProfilePresentationLogicSpy: MyProfilePresentationLogic {
    var presentWillFetchUserCalled: Bool = false
    var presentDidFetchUserCalled: Bool = false
    var presentUserCalled: Bool = false
    var presentResetUserCalled: Bool = false
    
    var presentWillFetchImageCalled: Bool = false
    var presentDidFetchImageCalled: Bool = false
    var presentImageCalled: Bool = false
    var presentPlaceholderImageCalled: Bool = false
    
    var presentWillLogoutUserCalled: Bool = false
    var presentDidLogoutUserCalled: Bool = false
    var presentLoggedOutUserCalled: Bool = false
    
    var presentNavigateToReportIssueCalled: Bool = false
    
    var presentErrorStateCalled: Bool = false
    var presentRemoveErrorStateCalled: Bool = false
    
    var presentErrorAlertCalled: Bool = false
    
    var presentNavigateToFullscreenImageCalled: Bool = false
    
    func presentWillFetchUser() {
        self.presentWillFetchUserCalled = true
    }
    
    func presentDidFetchUser() {
        self.presentDidFetchUserCalled = true
    }
    
    func presentUser(response: MyProfileModels.UserPresentation.Response) {
        self.presentUserCalled = true
    }
    
    func presentResetUser() {
        self.presentResetUserCalled = true
    }
    
    func presentWillFetchImage(response: MyProfileModels.ImageFetching.Response) {
        self.presentWillFetchImageCalled = true
    }
    
    func presentDidFetchImage(response: MyProfileModels.ImageFetching.Response) {
        self.presentDidFetchImageCalled = true
    }
    
    func presentImage(response: MyProfileModels.ImagePresentation.Response) {
        self.presentImageCalled = true
    }
    
    func presentPlaceholderImage(response: MyProfileModels.ImagePresentation.Response) {
        self.presentPlaceholderImageCalled = true
    }
    
    func presentWillLogoutUser() {
        self.presentWillLogoutUserCalled = true
    }
    
    func presentDidLogoutUser() {
        self.presentDidLogoutUserCalled = true
    }
    
    func presentLoggedOutUser() {
        self.presentLoggedOutUserCalled = true
    }
    
    func presentNavigateToReportIssue() {
        self.presentNavigateToReportIssueCalled = true
    }
    
    func presentErrorState() {
        self.presentErrorStateCalled = true
    }
    
    func presentRemoveErrorState() {
        self.presentRemoveErrorStateCalled = true
    }
    
    func presentErrorAlert(response: MyProfileModels.ErrorAlertPresentation.Response) {
        self.presentErrorAlertCalled = true
    }
    
    func presentNavigateToFullscreenImage(response: MyProfileModels.FullscreenImageNavigation.Response) {
        self.presentNavigateToFullscreenImageCalled = true
    }
}
