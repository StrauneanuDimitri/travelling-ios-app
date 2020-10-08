//
//  PlaceDetailsPresenterTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 08/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class PlaceDetailsPresenterTests: XCTestCase {
    var sut: PlaceDetailsPresenter!
    var displayerSpy: PlaceDetailsDisplayLogicSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupPlaceDetailsPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPlaceDetailsPresenter() {
        self.sut = PlaceDetailsPresenter()
        
        self.displayerSpy = PlaceDetailsDisplayLogicSpy()
        self.sut.displayer = self.displayerSpy
    }
    
    // MARK: - Tests
    
    
}
