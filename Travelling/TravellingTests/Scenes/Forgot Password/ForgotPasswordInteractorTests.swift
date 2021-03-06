//
//  ForgotPasswordInteractorTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 05/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class ForgotPasswordInteractorTests: XCTestCase {
    var sut: ForgotPasswordInteractor!
    var presenterSpy: ForgotPasswordPresentationLogicSpy!
    var workerSpy: ForgotPasswordWorkerSpy!
    var urlOpenerSpy: URLOpenableSpy!
  
    // MARK: - Test lifecycle
  
    override func setUp() {
        super.setUp()
        self.setupForgotPasswordInteractor()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: - Test setup
  
    func setupForgotPasswordInteractor() {
        self.sut = ForgotPasswordInteractor()
        
        self.presenterSpy = ForgotPasswordPresentationLogicSpy()
        self.sut.presenter = self.presenterSpy
        
        self.workerSpy = ForgotPasswordWorkerSpy(delegate: self.sut)
        self.sut.worker = self.workerSpy
        
        self.urlOpenerSpy = URLOpenableSpy()
        self.sut.urlOpener = self.urlOpenerSpy
    }
    
    private func waitForMainQueue() {
        let waitExpectation = expectation(description: "Waiting for main queue.")
        DispatchQueue.main.async {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Tests
    
    func testShouldSetupItems() {
        self.sut.shouldSetupItems()
        XCTAssertTrue(self.presenterSpy.presentSetupItemsCalled)
    }
    
    // MARK: - Email tests
    
    func testShouldUpdateEmail() {
        let text = "email"
        self.sut.shouldUpdateItem(request: ForgotPasswordModels.UpdateItem.Request(text: text, type: ForgotPasswordModels.ItemType.email))
        XCTAssertEqual(self.sut.email, text)
        XCTAssertTrue(self.presenterSpy.presentUpdateItemCalled)
    }
    
    func testShouldValidateEmailForInvalidEmail() {
        self.sut.email = "invalid.email"
        self.sut.shouldValidateItem(request: ForgotPasswordModels.ValidateItem.Request(type: ForgotPasswordModels.ItemType.email))
        XCTAssertTrue(self.presenterSpy.presentValidationErrorCalled)
    }
    
    func testShouldValidateEmailForValidEmail() {
        self.sut.email = "valid.email@email.com"
        self.sut.shouldValidateItem(request: ForgotPasswordModels.ValidateItem.Request(type: ForgotPasswordModels.ItemType.email))
        XCTAssertTrue(self.presenterSpy.presentValidationErrorCalled)
    }
    
    // MARK: - Enabling/Disabling items
    
    func testShouldUpdateItemWhenAllItemsAreValid() {
        self.sut.shouldUpdateItem(request: ForgotPasswordModels.UpdateItem.Request(text: "valid.email@email.com", type: ForgotPasswordModels.ItemType.email))
        XCTAssertTrue(self.presenterSpy.presentEnableItemCalled)
    }
    
    func testShouldUpdateItemWhenOnlyWhenEmailIsInvalid() {
        self.sut.shouldUpdateItem(request: ForgotPasswordModels.UpdateItem.Request(text: "email", type: ForgotPasswordModels.ItemType.email))
        XCTAssertTrue(self.presenterSpy.presentDisableItemCalled)
    }
    
    func testShouldOpenMailApplicationShouldAskThePresenterToOpenMailApplicationWhenItCanOpenEmail() {
        self.sut.emailUrl = URL(string: "https://url.com")
        self.urlOpenerSpy.canOpenURLValue = true
        self.sut.shouldOpenMailApplication()
        XCTAssertTrue(self.presenterSpy.presentOpenMailApplicationCalled)
    }
    
    func testShouldOpenMailApplicationShouldNotAskThePresenterToOpenMailApplicationWhenThereIsNoEmailUrl() {
        self.sut.emailUrl = nil
        self.urlOpenerSpy.canOpenURLValue = false
        self.sut.shouldOpenMailApplication()
        XCTAssertFalse(self.presenterSpy.presentOpenMailApplicationCalled)
    }
    
    // MARK: - Send reset link tests
    
    func testShouldSelectItemShouldAskThePresenterToPresentDisableUserInteractionForResetLinkItemType() {
        self.sut.shouldSelectItem(request: ForgotPasswordModels.ItemSelection.Request(type: .resetLink))
        XCTAssertTrue(self.presenterSpy.presentDisableUserInteractionCalled)
    }
    
    func testShouldSelectItemShouldAskThePresenterToPresentDisableItemForResetLinkItemType() {
        self.sut.shouldSelectItem(request: ForgotPasswordModels.ItemSelection.Request(type: .resetLink))
        XCTAssertTrue(self.presenterSpy.presentDisableItemCalled)
    }
    
    func testShouldSelectItemShouldAskThePresenterToPresentLoadingItemForResetLinkItemType() {
        self.sut.shouldSelectItem(request: ForgotPasswordModels.ItemSelection.Request(type: .resetLink))
        XCTAssertTrue(self.presenterSpy.presentLoadingItemCalled)
    }
    
    func testShouldSelectItemShouldAskTheWorkerToSendResetLinkForResetLinkItemType() {
        self.sut.shouldSelectItem(request: ForgotPasswordModels.ItemSelection.Request(type: .resetLink))
        XCTAssertTrue(self.workerSpy.sendResetLinkCalled)
    }
    
    func testSuccessDidSendResetLinkShouldAskThePresenterToPresentNotLoadingItem() {
        self.sut.successDidSendResetLink(email: "email")
        XCTAssertTrue(self.presenterSpy.presentNotLoadingItemCalled)
    }
    
    func testSuccessDidSendResetLinkShouldAskThePresenterToPresentEnableItem() {
        self.sut.successDidSendResetLink(email: "email")
        XCTAssertTrue(self.presenterSpy.presentEnableItemCalled)
    }
    
    func testSuccessDidSendResetLinkShouldAskThePresenterToPresentEnableUserInteraction() {
        self.sut.successDidSendResetLink(email: "email")
        XCTAssertTrue(self.presenterSpy.presentEnableUserInteractionCalled)
    }
    
    func testSuccessDidSendResetLinkShouldAskThePresenterToPresentConfirmationEmailAlertWhenItCanOpenEmail() {
        self.sut.emailUrl = URL(string: "https://url.com")
        self.urlOpenerSpy.canOpenURLValue = true
        self.sut.successDidSendResetLink(email: "email")
        self.waitForMainQueue()
        XCTAssertTrue(self.presenterSpy.presentConfirmationEmailAlertCalled)
    }
    
    func testSuccessDidSendResetLinkShouldAskThePresenterToPresentConfirmationAlertWhenItCannotOpenEmail() {
        self.urlOpenerSpy.canOpenURLValue = false
        self.sut.successDidSendResetLink(email: "email")
        self.waitForMainQueue()
        XCTAssertTrue(self.presenterSpy.presentConfirmationAlertCalled)
    }
    
    func testFailureDidSendResetLinkShouldAskThePresenterToPresentNotLoadingItem() {
        self.sut.failureDidSendResetLink(email: "email", error: OperationError.noDataAvailable)
        XCTAssertTrue(self.presenterSpy.presentNotLoadingItemCalled)
    }
    
    func testFailureDidSendResetLinkShouldAskThePresenterToPresentEnableItem() {
        self.sut.failureDidSendResetLink(email: "email", error: OperationError.noDataAvailable)
        XCTAssertTrue(self.presenterSpy.presentEnableItemCalled)
    }
    
    func testFailureDidSendResetLinkShouldAskThePresenterToPresentEnableUserInteraction() {
        self.sut.failureDidSendResetLink(email: "email", error: OperationError.noDataAvailable)
        XCTAssertTrue(self.presenterSpy.presentEnableUserInteractionCalled)
    }
    
    func testFailureDidSendResetLinkShouldAskThePresenterToPresentErrorAlert() {
        self.sut.failureDidSendResetLink(email: "email", error: OperationError.noDataAvailable)
        XCTAssertTrue(self.presenterSpy.presentErrorAlertCalled)
    }
}
