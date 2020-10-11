//
//  MyFavoritePlacesViewControllerTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 11/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class MyFavoritePlacesViewControllerTests: XCTestCase {
    var sut: MyFavoritePlacesViewController!
    var interactorSpy: MyFavoritePlacesBusinessLogicSpy!
    var routerSpy: MyFavoritePlacesRoutingLogicSpy!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupMyFavoritePlacesViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMyFavoritePlacesViewController() {
        self.sut = MyFavoritePlacesViewController()
        
        self.interactorSpy = MyFavoritePlacesBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = MyFavoritePlacesRoutingLogicSpy()
        self.sut.router = self.routerSpy
    }
    
    func loadView() {
        self.window.addSubview(self.sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Tests
    
    
}