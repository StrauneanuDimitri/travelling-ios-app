//
//  MyProfileWorkerTests.swift
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
import XCTest

class MyProfileWorkerTests: XCTestCase {
    var sut: MyProfileWorker!
    var delegateSpy: MyProfileWorkerDelegateSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupMyProfileWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMyProfileWorker() {
        self.delegateSpy = MyProfileWorkerDelegateSpy()
        self.sut = MyProfileWorker(delegate: self.delegateSpy)
    }
    
    // MARK: - Tests
    
    func testFetchImage() {
        let taskSpy = ImageTaskSpy()
        self.sut.imageTask = taskSpy
        self.sut.fetchImage(model: MyProfileModels.UserModel())
        XCTAssertTrue(taskSpy.fetchImageCalled)
    }
    
    func testFetchImageShouldAskTheDelegateToSendImageForSuccessCase() {
        let taskSpy = ImageTaskSpy()
        taskSpy.shouldFailFetchImage = false
        self.sut.imageTask = taskSpy
        self.sut.fetchImage(model: MyProfileModels.UserModel())
        XCTAssertTrue(self.delegateSpy.successDidFetchImageCalled)
    }
    
    func testFetchImageShouldAskTheDelegateToSendErrorForFailureCase() {
        let taskSpy = ImageTaskSpy()
        taskSpy.shouldFailFetchImage = true
        self.sut.imageTask = taskSpy
        self.sut.fetchImage(model: MyProfileModels.UserModel())
        XCTAssertTrue(self.delegateSpy.failureDidFetchImageCalled)
    }
}