//
//  ExploreRouterTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 13/09/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class ExploreRouterTests: XCTestCase {
    var sut: ExploreRouter!
    var viewController: ExploreViewController!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupExploreRouter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupExploreRouter() {
        self.sut = ExploreRouter()
        
        self.viewController = ExploreViewController()
        self.sut.viewController = self.viewController
    }
    
    // MARK: - Tests
    
    func testNavigateToPlaceDetails() {
        let navigationControllerSpy = UINavigationControllerSpy(rootViewController: self.sut.viewController!)
        self.sut.navigateToPlaceDetails(place: Place(id: "placeId", location: Location(id: "locationId", latitude: 47, longitude: 27)))
        XCTAssertTrue(navigationControllerSpy.pushedViewController is PlaceDetailsViewController)
    }
}
