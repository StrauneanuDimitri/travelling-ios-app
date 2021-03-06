//
//  PlaceDetailsBusinessLogicSpy.swift
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

class PlaceDetailsBusinessLogicSpy: PlaceDetailsBusinessLogic {
    var shouldSetupPlaceCalled: Bool = false
    var shouldRefreshPlaceCalled: Bool = false
    var shouldFetchImageCalled: Bool = false
    var shouldSelectPhotoCalled: Bool = false
    var shouldSharePlaceCalled: Bool = false
    var shouldNavigateToPlaceCommentsCalled: Bool = false
    
    func shouldSetupPlace(request: PlaceDetailsModels.PlaceSetup.Request) {
        self.shouldSetupPlaceCalled = true
    }
    
    func shouldRefreshPlace() {
        self.shouldRefreshPlaceCalled = true
    }
    
    func shouldFetchImage(request: PlaceDetailsModels.ImageFetching.Request) {
        self.shouldFetchImageCalled = true
    }
    
    func shouldSelectPhoto() {
        self.shouldSelectPhotoCalled = true
    }
    
    func shouldSharePlace() {
        self.shouldSharePlaceCalled = true
    }
    
    func shouldNavigateToPlaceComments() {
        self.shouldNavigateToPlaceCommentsCalled = true
    }
}
