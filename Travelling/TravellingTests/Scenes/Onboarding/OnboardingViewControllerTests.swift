//
//  OnboardingViewControllerTests.swift
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

class OnboardingViewControllerTests: XCTestCase {
    var sut: OnboardingViewController!
    var interactorSpy: OnboardingBusinessLogicSpy!
    var routerSpy: OnboardingRoutingLogicSpy!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupOnboardingViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupOnboardingViewController() {
        self.sut = OnboardingViewController()
        
        self.interactorSpy = OnboardingBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = OnboardingRoutingLogicSpy()
        self.sut.router = self.routerSpy
    }
    
    func loadView() {
        self.window.addSubview(self.sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Tests
    
    func testTouchUpInsideDismissButton() {
        self.sut.touchUpInsideDismissButton()
        XCTAssertTrue(self.routerSpy.dismissCalled)
    }
    
    func testTouchUpInsideLoginButton() {
        self.sut.touchUpInsideLoginButton()
        XCTAssertTrue(self.routerSpy.navigateToLoginCalled)
    }
    
    func testTouchUpInsideSignUpButton() {
        self.sut.touchUpInsideSignUpButton()
        XCTAssertTrue(self.routerSpy.navigateToSignUpCalled)
    }
}