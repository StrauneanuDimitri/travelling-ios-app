//
//  MainInteractorTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 12/09/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class MainInteractorTests: XCTestCase {
    var sut: MainInteractor!
    var presenterSpy: MainPresentationLogicSpy!
    var workerSpy: MainWorkerSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupMainInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMainInteractor() {
        self.sut = MainInteractor()
        
        self.presenterSpy = MainPresentationLogicSpy()
        self.sut.presenter = self.presenterSpy
        
        self.workerSpy = MainWorkerSpy(delegate: self.sut)
        self.sut.worker = self.workerSpy
    }
    
    // MARK: - Tests
    
    func testShouldSetupScenesShouldAskThePresenterToPresentSetupScenes() {
        self.sut.shouldSetupScenes()
        XCTAssertTrue(self.presenterSpy.presentSetupScenesCalled)
    }
    
    func testShouldSelectInitialSceneShouldAskThePresenterToPresentInitialSelectScene() {
        self.sut.shouldSelectInitialScene()
        XCTAssertTrue(self.presenterSpy.presentSelectSceneCalled)
    }
}
