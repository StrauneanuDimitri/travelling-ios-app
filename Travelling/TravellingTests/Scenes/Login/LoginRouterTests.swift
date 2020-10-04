//
//  LoginRouterTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 04/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class LoginRouterTests: XCTestCase {
    var sut: LoginRouter!
    var viewControllerSpy: LoginViewControllerSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupLoginRouter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupLoginRouter() {
        self.sut = LoginRouter()
        
        self.viewControllerSpy = LoginViewControllerSpy()
        self.sut.viewController = self.viewControllerSpy
    }
    
    // MARK: - Tests
    
    func testNavigateToForgotPassword() {
        // TODO: - Add test!
        let navigationControllerSpy = UINavigationControllerSpy(rootViewController: self.sut.viewController!)
        self.sut.navigateToForgotPassword()
        // XCTAssertTrue(navigationControllerSpy.pushedViewController is ForgotPasswordViewController)
    }
    
    func testNavigateToAlert() {
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        self.sut.navigateToAlert(title: "Title", message: "Message", actions: [action])
        XCTAssertTrue(self.viewControllerSpy.presentCalled)
    }
}