//
//  MyFavoritePlacesWorkerTests.swift
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

class MyFavoritePlacesWorkerTests: XCTestCase {
    var sut: MyFavoritePlacesWorker!
    var delegateSpy: MyFavoritePlacesWorkerDelegateSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupMyFavoritePlacesWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMyFavoritePlacesWorker() {
        self.delegateSpy = MyFavoritePlacesWorkerDelegateSpy()
        self.sut = MyFavoritePlacesWorker(delegate: self.delegateSpy)
    }
    
    // MARK: - Tests
    
    
}