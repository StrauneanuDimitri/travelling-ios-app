//
//  SignUpWorkerTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 06/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class SignUpWorkerTests: XCTestCase {
    var sut: SignUpWorker!
    var delegateSpy: SignUpWorkerDelegateSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupSignUpWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupSignUpWorker() {
        self.delegateSpy = SignUpWorkerDelegateSpy()
        self.sut = SignUpWorker(delegate: self.delegateSpy)
    }
    
    func waitForGlobalQueue() {
        let waitExpectation = expectation(description: "Waiting for global queue.")
        DispatchQueue.global().async {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Tests
    
    func testSignUpUser() {
        let taskSpy = AuthenticationTaskSpy()
        self.sut.authenticationTask = taskSpy
        self.sut.signUpUser(details: SignUpModels.UserDetails())
        self.waitForGlobalQueue()
        XCTAssertTrue(taskSpy.signUpUserCalled)
    }
    
    func testSignUpUserShouldAskTheDelegateToSendUserForSuccessCase() {
        let taskSpy = AuthenticationTaskSpy()
        taskSpy.shouldFailSignUpUser = false
        self.sut.authenticationTask = taskSpy
        self.sut.signUpUser(details: SignUpModels.UserDetails())
        self.waitForGlobalQueue()
        XCTAssertTrue(self.delegateSpy.successDidSignUpUserCalled)
    }
    
    func testSignUpUserShouldAskTheDelegateToSendErrorForFailureCase() {
        let taskSpy = AuthenticationTaskSpy()
        taskSpy.shouldFailSignUpUser = true
        self.sut.authenticationTask = taskSpy
        self.sut.signUpUser(details: SignUpModels.UserDetails())
        self.waitForGlobalQueue()
        XCTAssertTrue(self.delegateSpy.failureDidSignUpUserCalled)
    }
}