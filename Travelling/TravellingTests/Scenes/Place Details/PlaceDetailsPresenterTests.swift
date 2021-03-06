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
    
    func testPresentWillFetchPlaceShouldAskTheDisplayerToDisplayWillFetchPlace() {
        self.sut.presentWillFetchPlace()
        XCTAssertTrue(self.displayerSpy.displayWillFetchPlaceCalled)
    }
    
    func testPresentDidFetchPlaceShouldAskTheDisplayerToDisplayDidFetchPlace() {
        self.sut.presentDidFetchPlace()
        XCTAssertTrue(self.displayerSpy.displayDidFetchPlaceCalled)
    }
    
    func testPresentPlaceShouldAskTheDisplayerToDisplayPlace() {
        self.sut.presentPlace(response: PlaceDetailsModels.PlacePresentation.Response(place: Place(id: "placeId", location: Location(id: "locationId", latitude: 20, longitude: 20))))
        XCTAssertTrue(self.displayerSpy.displayPlaceCalled)
    }
    
    func testPresentPlaceShouldFormatItemsForDisplay() {
        let place = self.place()
        self.sut.presentPlace(response: PlaceDetailsModels.PlacePresentation.Response(place: place))
        XCTAssertEqual(self.displayerSpy.displayPlaceViewModel.items.count, PlaceDetailsModels.ItemType.allCases.count)
    }
    
    func testPresentPlaceShouldFormatPhotoItemForDisplay() {
        let place = self.place()
        self.sut.presentPlace(response: PlaceDetailsModels.PlacePresentation.Response(place: place))
        let photoModel = self.displayerSpy.displayPlaceViewModel.items.first(where: { $0.type == .photo })?.model as? PlaceDetailsModels.PhotoModel
        XCTAssertEqual(photoModel?.imageName, place.photo?.imageName)
        XCTAssertEqual(photoModel?.imageDominantColor, place.photo?.imageDominantColor?.hexColor())
    }
    
    func testPresentPlaceShouldFormatDescriptionItemForDisplay() {
        let place = self.place()
        self.sut.presentPlace(response: PlaceDetailsModels.PlacePresentation.Response(place: place))
        let descriptionModel = self.displayerSpy.displayPlaceViewModel.items.first(where: { $0.type == .description })?.model as? PlaceDetailsModels.DescriptionModel
        XCTAssertEqual(descriptionModel?.text, place.description?.attributed(attributes: PlaceDetailsStyle.shared.descriptionCellModel.textAttributes()))
    }
    
    func testPresentResetPlaceShouldAskTheDisplayerToDisplayResetPlace() {
        self.sut.presentResetPlace()
        XCTAssertTrue(self.displayerSpy.displayResetPlaceCalled)
    }
    
    func testPresentWillFetchImageShouldAskTheDisplayerToDisplayWillFetchImage() {
        self.sut.presentWillFetchImage(response: PlaceDetailsModels.ImageFetching.Response(model: PlaceDetailsModels.PhotoModel()))
        XCTAssertTrue(self.displayerSpy.displayWillFetchImageCalled)
    }
    
    func testPresentDidFetchImageShouldAskTheDisplayerToDisplayDidFetchImage() {
        self.sut.presentDidFetchImage(response: PlaceDetailsModels.ImageFetching.Response(model: PlaceDetailsModels.PhotoModel()))
        XCTAssertTrue(self.displayerSpy.displayDidFetchImageCalled)
    }
    
    func testPresentImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentImage(response: PlaceDetailsModels.ImagePresentation.Response(model: PlaceDetailsModels.PhotoModel(), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
    
    func testPresentPlaceholderImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentPlaceholderImage(response: PlaceDetailsModels.ImagePresentation.Response(model: PlaceDetailsModels.PhotoModel(), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
    
    func testPresentErrorStateShouldAskTheDisplayerToDisplayErrorState() {
        self.sut.presentErrorState()
        XCTAssertTrue(self.displayerSpy.displayErrorStateCalled)
    }
    
    func testPresentRemoveErrorStateShouldAskTheDisplayerToDisplayRemoveErrorState() {
        self.sut.presentRemoveErrorState()
        XCTAssertTrue(self.displayerSpy.displayRemoveErrorStateCalled)
    }
    
    func testPresentErrorAlertShouldAskTheDisplayerToDisplayErrorAlert() {
        self.sut.presentErrorAlert(response: PlaceDetailsModels.ErrorAlertPresentation.Response(error: OperationError.noDataAvailable))
        XCTAssertTrue(self.displayerSpy.displayErrorAlertCalled)
    }
    
    func testPresentNavigateToFullscreenImageShouldAskTheDisplayerToDisplayNavigateToFullscreenImage() {
        self.sut.presentNavigateToFullscreenImage(response: PlaceDetailsModels.FullscreenImageNavigation.Response(imageName: "imageName"))
        XCTAssertTrue(self.displayerSpy.displayNavigateToFullscreenImageCalled)
    }
    
    func testPresentNavigateToPlaceCommentsShouldAskTheDisplayerToDisplayNavigateToPlaceComments() {
        self.sut.presentNavigateToPlaceComments(response: PlaceDetailsModels.PlaceCommentsNavigation.Response(placeId: "placeId"))
        XCTAssertTrue(self.displayerSpy.displayNavigateToPlaceCommentsCalled)
    }
    
    func testPresentPlaceTitleShouldAskTheDisplayerToDisplayPlaceTitle() {
        self.sut.presentPlaceTitle(response: PlaceDetailsModels.TitlePresentation.Response(place: Place(id: "placeId", location: Location(id: "locationId", latitude: 20, longitude: 20))))
        XCTAssertTrue(self.displayerSpy.displayPlaceTitleCalled)
    }
    
    func testPresentSharePlaceShouldAskTheDisplayerToDisplaySharePlace() {
        self.sut.presentSharePlace(response: PlaceDetailsModels.PlaceSharing.Response(place: Place(id: "placeId", location: Location(id: "locationId", latitude: 20, longitude: 20))))
        XCTAssertTrue(self.displayerSpy.displaySharePlaceCalled)
    }
}

// MARK: - Auxiliary

extension PlaceDetailsPresenterTests {
    private func place() -> Place {
        let place = Place(id: "placeId", location: Location(id: "locationId", latitude: 20, longitude: 20))
        place.createdAt = "2020-05-23T13:25:16Z"
        place.commentCount = 50
        place.name = "Name"
        place.description = "Description"
        place.photo = self.photo()
        return place
    }
    
    private func photo() -> Photo {
        let photo = Photo(id: "photoId")
        photo.imageName = "imageName"
        photo.imageDominantColor = "#FFFFFF"
        return photo
    }
}
