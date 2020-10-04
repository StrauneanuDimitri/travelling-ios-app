//
//  FullscreenImagePresenterTests.swift
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

class FullscreenImagePresenterTests: XCTestCase {
    var sut: FullscreenImagePresenter!
    var displayerSpy: FullscreenImageDisplayLogicSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupFullscreenImagePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupFullscreenImagePresenter() {
        self.sut = FullscreenImagePresenter()
        
        self.displayerSpy = FullscreenImageDisplayLogicSpy()
        self.sut.displayer = self.displayerSpy
    }
    
    // MARK: - Tests
    
    func testPresentWillFetchImageShouldAskTheDisplayerToDisplayWillFetchImage() {
        self.sut.presentWillFetchImage()
        XCTAssertTrue(self.displayerSpy.displayWillFetchImageCalled)
    }
    
    func testPresentDidFetchImageShouldAskTheDisplayerToDisplayDidFetchImage() {
        self.sut.presentDidFetchImage()
        XCTAssertTrue(self.displayerSpy.displayDidFetchImageCalled)
    }
    
    func testPresentImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentImage(response: FullscreenImageModels.ImagePresentation.Response(image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
    
    func testPresentPlaceholderImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentPlaceholderImage()
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
}