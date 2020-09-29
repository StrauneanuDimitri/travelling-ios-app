//
//  MyProfilePresenterTests.swift
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

class MyProfilePresenterTests: XCTestCase {
    var sut: MyProfilePresenter!
    var displayerSpy: MyProfileDisplayLogicSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupMyProfilePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMyProfilePresenter() {
        self.sut = MyProfilePresenter()
        
        self.displayerSpy = MyProfileDisplayLogicSpy()
        self.sut.displayer = self.displayerSpy
    }
    
    // MARK: - Tests
    
    func testPresentWillFetchUserShouldAskTheDisplayerToDisplayWillFetchUser() {
        self.sut.presentWillFetchUser()
        XCTAssertTrue(self.displayerSpy.displayWillFetchUserCalled)
    }
    
    func testPresentDidFetchUserShouldAskTheDisplayerToDisplayDidFetchUser() {
        self.sut.presentDidFetchUser()
        XCTAssertTrue(self.displayerSpy.displayDidFetchUserCalled)
    }
        
    func testPresentUserShouldAskTheDisplayerToDisplayUser() {
        self.sut.presentUser(response: MyProfileModels.UserPresentation.Response(user: User(id: "id")))
        XCTAssertTrue(self.displayerSpy.displayUserCalled)
    }
    
    func testPresentUserShouldFormatItemsForDisplay() {
        let user = self.user()
        self.sut.presentUser(response: MyProfileModels.UserPresentation.Response(user: user))
        XCTAssertEqual(self.displayerSpy.displayUserViewModel.items.count, MyProfileModels.ItemType.allCases.count)
    }
    
    func testPresentUserShouldFormatUserItemForDisplay() {
        let user = self.user()
        self.sut.presentUser(response: MyProfileModels.UserPresentation.Response(user: user))
        let userModel = self.displayerSpy.displayUserViewModel.items.first(where: { $0.type == .user })?.model as? MyProfileModels.UserModel
        XCTAssertEqual(userModel?.name?.string, String(format: "%@ %@", user.firstName ?? "", user.lastName ?? ""))
        XCTAssertEqual(userModel?.title?.string, user.title)
        XCTAssertEqual(userModel?.description?.string, user.description)
        XCTAssertEqual(userModel?.imageDominantColor, user.photo?.imageDominantColor?.hexColor())
    }
    
    func testPresentWillFetchImageShouldAskTheDisplayerToDisplayWillFetchImage() {
        self.sut.presentWillFetchImage(response: MyProfileModels.ImageFetching.Response(model: MyProfileModels.UserModel()))
        XCTAssertTrue(self.displayerSpy.displayWillFetchImageCalled)
    }
    
    func testPresentDidFetchImageShouldAskTheDisplayerToDisplayDidFetchImage() {
        self.sut.presentDidFetchImage(response: MyProfileModels.ImageFetching.Response(model: MyProfileModels.UserModel()))
        XCTAssertTrue(self.displayerSpy.displayDidFetchImageCalled)
    }
    
    func testPresentImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentImage(response: MyProfileModels.ImagePresentation.Response(model: MyProfileModels.UserModel(), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
    
    func testPresentPlaceholderImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentPlaceholderImage(response: MyProfileModels.ImagePresentation.Response(model: MyProfileModels.UserModel(), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
    
    func testPresentWillLogoutUserShouldAskTheDisplayerToDisplayWillLogoutUser() {
        self.sut.presentWillLogoutUser()
        XCTAssertTrue(self.displayerSpy.displayWillLogoutUserCalled)
    }
    
    func testPresentDidLogoutUserShouldAskTheDisplayerToDisplayDidLogoutUser() {
        self.sut.presentDidLogoutUser()
        XCTAssertTrue(self.displayerSpy.displayDidLogoutUserCalled)
    }
    
    func testPresentLoggedOutUserShouldAskTheDisplayerToDisplayLoggedOutUser() {
        self.sut.presentLoggedOutUser()
        XCTAssertTrue(self.displayerSpy.displayLoggedOutUserCalled)
    }
    
    func testPresentNavigateToReportIssueShouldAskTheDisplayerToDisplayNavigateToEmail() {
        self.sut.presentNavigateToReportIssue()
        XCTAssertTrue(self.displayerSpy.displayNavigateToEmailCalled)
    }
}

// MARK: - Auxiliary

extension MyProfilePresenterTests {
    private func user() -> User {
        let user = User(id: "userId")
        user.firstName = "First name"
        user.lastName = "Last name"
        user.title = "Title"
        user.description = "Description"
        user.photo = self.photo()
        return user
    }
    
    private func photo() -> Photo {
        let photo = Photo(id: "photoId")
        photo.imageDominantColor = "#FFFFFF"
        return photo
    }
}
