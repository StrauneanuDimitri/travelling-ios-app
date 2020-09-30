//
//  MyProfileViewControllerTests.swift
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

class MyProfileViewControllerTests: XCTestCase {
    var sut: MyProfileViewController!
    var interactorSpy: MyProfileBusinessLogicSpy!
    var routerSpy: MyProfileRoutingLogicSpy!
    var delegateSpy: MyProfileViewControllerDelegateSpy!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupMyProfileViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMyProfileViewController() {
        self.sut = MyProfileViewController()
        
        self.interactorSpy = MyProfileBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = MyProfileRoutingLogicSpy()
        self.sut.router = self.routerSpy
        
        self.delegateSpy = MyProfileViewControllerDelegateSpy()
        self.sut.delegate = self.delegateSpy
    }
    
    func loadView() {
        self.window.addSubview(self.sut.view)
        RunLoop.current.run(until: Date())
    }
    
    private func waitForMainQueue() {
        let waitExpectation = expectation(description: "Waiting for main queue.")
        DispatchQueue.main.async {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Table view tests
    
    func testNumberOfRowsInItemsSectionShouldEqualItemsCount() {
        self.loadView()
        self.sut.items = [MyProfileModels.DisplayedItem(type: .user, model: nil)]
        let numberOfRows = self.sut.tableView(self.sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, self.sut.items.count)
    }
    
    func testCellForRowShouldReturnCorrectCellForItems() {
        self.loadView()
        self.sut.items = [MyProfileModels.DisplayedItem(type: .user, model: MyProfileModels.UserModel()), MyProfileModels.DisplayedItem(type: .logout, model: MyProfileModels.TitleModel())]
        
        let informationCell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let titleCell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        
        XCTAssertTrue(informationCell is MyProfileInformationTableViewCell)
        XCTAssertTrue(titleCell is MyProfileTitleTableViewCell)
    }
    
    func testShouldConfigureInformationTableViewCell() {
        self.loadView()
        
        let model = MyProfileModels.UserModel()
        model.name = "Name".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        model.title = "Title".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        model.description = "Description".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        model.isLoadingImage = true
        model.image = UIImage()
        model.imageContentMode = .center
        model.imageDominantColor = UIColor.white
        
        let items = [MyProfileModels.DisplayedItem(type: .user, model: model)]
        self.sut.items = items
        items.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: index, section: 0)) as! MyProfileInformationTableViewCell
            guard let model = item.model as? MyProfileModels.UserModel else {
                return XCTAssertTrue(false, "Wrong model for item!")
            }
            XCTAssertNotNil(model.cellInterface)
            XCTAssertEqual(cell.nameLabel?.attributedText, model.name)
            XCTAssertEqual(cell.titleLabel?.attributedText, model.title)
            XCTAssertEqual(cell.descriptionLabel?.attributedText, model.description)
            XCTAssertEqual(cell.avatarImageView?.activityIndicatorView?.isHidden, !model.isLoadingImage)
            XCTAssertEqual(cell.avatarImageView?.image, model.image)
            XCTAssertEqual(cell.avatarImageView?.contentMode, model.imageContentMode)
            XCTAssertEqual(cell.avatarImageView?.backgroundColor, model.imageDominantColor)
            XCTAssertTrue(self.interactorSpy.shouldFetchImageCalled)
        }
    }
    
    func testShouldConfigureTitleTableViewCell() {
        self.loadView()
        
        let model = MyProfileModels.TitleModel(title: "Title".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]), isSelectable: true)
        let items = [MyProfileModels.DisplayedItem(type: .logout, model: model)]
        self.sut.items = items
        items.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: index, section: 0)) as! MyProfileTitleTableViewCell
            guard let model = item.model as? MyProfileModels.TitleModel else {
                return XCTAssertTrue(false, "Wrong model for item!")
            }
            XCTAssertEqual(cell.textLabel?.attributedText, model.title)
            XCTAssertEqual(cell.selectionStyle, model.isSelectable ? .default : .none)
        }
    }
    
    func testTableViewDidSelectRowAtShouldAskTheInteractorToSelectItem() {
        self.loadView()
        self.sut.items = [MyProfileModels.DisplayedItem(type: .user, model: nil)]
        self.sut.tableView(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(self.interactorSpy.shouldSelectItemCalled)
    }
    
    func testTableViewDidSelectRowAtShouldAskTheTableViewToDeselectRow() {
        self.loadView()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.items = [MyProfileModels.DisplayedItem(type: .user, model: nil)]
        self.sut.tableView(tableViewSpy, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(tableViewSpy.deselectRowCalled)
    }
    
    // MARK: - Business logic tests
    
    func testViewDidLoadShouldAskTheInteractorToFetchUser() {
        self.loadView()
        XCTAssertTrue(self.interactorSpy.shouldFetchUserCalled)
    }
    
    func testErrorStateViewTouchUpInsideButtonShouldAskTheInteractorToFetchUser() {
        self.sut.errorStateView(view: nil, touchUpInsideButton: nil)
        XCTAssertTrue(self.interactorSpy.shouldFetchUserCalled)
    }
    
    func testValueChangedRefreshControlShouldAskTheInteractorToRefreshUser() {
        self.sut.valueChangedRefreshControl(refreshControl: UIRefreshControl())
        XCTAssertTrue(self.interactorSpy.shouldRefreshUserCalled)
    }
    
    func testValueChangedRefreshControlShouldAskTheRefreshControlToEndRefreshing() {
        let refreshControlSpy = UIRefreshControlSpy()
        self.sut.valueChangedRefreshControl(refreshControl: refreshControlSpy)
        XCTAssertTrue(refreshControlSpy.endRefreshingCalled)
    }
    
    // MARK: - Display logic tests
        
    func testDisplayWillFetchUser() {
        self.loadView()
        self.sut.tableView?.tableFooterView = nil
        self.sut.displayWillFetchUser()
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.tableView?.tableFooterView)
        XCTAssertTrue(self.sut.tableView?.tableFooterView is UIActivityIndicatorView)
    }
    
    func testDisplayDidFetchUser() {
        self.loadView()
        self.sut.tableView?.tableFooterView = UIActivityIndicatorView(style: .medium)
        self.sut.displayDidFetchUser()
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.tableView?.tableFooterView)
        XCTAssertFalse(self.sut.tableView?.tableFooterView is UIActivityIndicatorView)
    }
    
    func testDisplayUserShouldUpdateDisplayedItems() {
        self.sut.items = []
        let items: [MyProfileModels.DisplayedItem] = [MyProfileModels.DisplayedItem(type: .user, model: nil)]
        self.sut.displayUser(viewModel: MyProfileModels.UserPresentation.ViewModel(items: items))
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.items, items)
    }
    
    func testDisplayUserShouldAskTheTableViewToReloadData() {
        self.loadView()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayUser(viewModel: MyProfileModels.UserPresentation.ViewModel(items: []))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadDataCalled)
    }
    
    func testDisplayResetUserShouldResetDisplayedItems() {
        self.sut.items = [MyProfileModels.DisplayedItem(type: .user, model: nil)]
        self.sut.displayResetUser()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.items.isEmpty)
    }
    
    func testDisplayResetUserShouldAskTheTableViewToReloadData() {
        self.loadView()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayResetUser()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadDataCalled)
    }
    
    func testDisplayWillFetchImage() {
        let spy = MyProfileInformationTableViewCellInterfaceSpy()
        let model = MyProfileModels.UserModel()
        model.cellInterface = spy
        model.isLoadingImage = false
        self.sut.displayWillFetchImage(viewModel: MyProfileModels.ImageFetching.ViewModel(model: model))
        self.waitForMainQueue()
        XCTAssertTrue(model.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayDidFetchImage() {
        let spy = MyProfileInformationTableViewCellInterfaceSpy()
        let model = MyProfileModels.UserModel()
        model.cellInterface = spy
        model.isLoadingImage = true
        self.sut.displayDidFetchImage(viewModel: MyProfileModels.ImageFetching.ViewModel(model: model))
        self.waitForMainQueue()
        XCTAssertFalse(model.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayImage() {
        let spy = MyProfileInformationTableViewCellInterfaceSpy()
        let model = MyProfileModels.UserModel()
        model.cellInterface = spy
        model.image = nil
        model.imageContentMode = .center
        let image = UIImage()
        let contentMode = UIView.ContentMode.scaleAspectFill
        self.sut.displayImage(viewModel: MyProfileModels.ImagePresentation.ViewModel(model: model, image: image, contentMode: contentMode))
        self.waitForMainQueue()
        XCTAssertEqual(model.image, image)
        XCTAssertEqual(model.imageContentMode, contentMode)
        XCTAssertTrue(spy.setImageCalled)
    }
    
    func testDisplayWillLogoutUserShouldDisableTableViewUserInteraction() {
        self.sut.tableView.isUserInteractionEnabled = true
        self.sut.displayWillLogoutUser()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.tableView.isUserInteractionEnabled)
    }
    
    func testDisplayWillLogoutUserShouldAddActivityIndicatorToRightBarButtonItem() {
        self.sut.navigationItem.rightBarButtonItem = nil
        self.sut.displayWillLogoutUser()
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.navigationItem.rightBarButtonItem)
        XCTAssertTrue(self.sut.navigationItem.rightBarButtonItem?.customView is UIActivityIndicatorView)
    }
    
    func testDisplayDidLogoutUserShouldEnableTableViewUserInteraction() {
        self.sut.tableView.isUserInteractionEnabled = false
        self.sut.displayDidLogoutUser()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.tableView.isUserInteractionEnabled)
    }
    
    func testDisplayDidLogoutUserShouldRemoveActivityIndicatorFromRightBarButtonItem() {
        self.sut.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIActivityIndicatorView(frame: .zero))
        self.sut.displayDidLogoutUser()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.navigationItem.rightBarButtonItem)
    }
    
    func testDisplayLoggedOutUserShouldAskTheDelegateToLogoutUser() {
        self.sut.displayLoggedOutUser()
        self.waitForMainQueue()
        XCTAssertTrue(self.delegateSpy.myProfileViewControllerDidLogoutUserCalled)
    }
    
    func testDisplayNavigateToEmailShouldAskTheRouterToNavigateToEmail() {
        self.sut.displayNavigateToEmail(viewModel: MyProfileModels.EmailNavigation.ViewModel(recipient: "recipient", subject: "subject"))
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToEmailCalled)
    }
    
    func testDisplayErrorStateShouldSetTableViewBackgroundView() {
        self.loadView()
        self.sut.tableView?.backgroundView = nil
        self.sut.displayErrorState(viewModel: MyProfileModels.ErrorStatePresentation.ViewModel(image: nil, text: "Text".attributed()))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.tableView?.backgroundView)
        XCTAssertTrue(self.sut.tableView?.backgroundView is ErrorStateView)
    }
    
    func testDisplayRemoveErrorStateShouldRemoveTableViewBackgroundView() {
        self.loadView()
        self.sut.tableView?.backgroundView = ErrorStateView(frame: .zero)
        self.sut.displayRemoveErrorState()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.tableView?.backgroundView)
    }
    
    func testDisplayErrorAlertShouldAskTheRouterToNavigateToAlert() {
        self.sut.displayErrorAlert(viewModel: MyProfileModels.ErrorAlertPresentation.ViewModel(title: "Title", message: "Message", cancelTitle: "Cancel"))
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToAlertCalled)
    }
}
