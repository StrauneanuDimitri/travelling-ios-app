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
    
    private func waitForMainQueue() {
        let waitExpectation = expectation(description: "Waiting for main queue.")
        DispatchQueue.main.async {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Tests
    
    func testInitializerWithCoder() {
        XCTAssertNil(MyFavoritePlacesViewController(coder: NSCoder()))
    }
    
    func testShouldSetupDataSourceWhenTheViewDidLoad() {
        self.loadView()
        XCTAssertEqual(self.sut.sections.count, 2)
    }
    
    // MARK: - Subviews tests
    
    func testAddSubviewsWhenViewDidLoad() {
        self.loadView()
        XCTAssertNotNil(self.sut.tableView)
    }
    
    // MARK: - Table view tests
    
    func testIfViewControllerHasSetTableViewDataSource() {
        self.loadView()
        XCTAssertNotNil(self.sut.tableView.dataSource)
    }
    
    func testIfViewControllerHasSetTableViewDelegate() {
        self.loadView()
        XCTAssertNotNil(self.sut.tableView.delegate)
    }
    
    func testIfViewControllerConformsToTableViewDataSource() {
        XCTAssertTrue(self.sut.conforms(to: UITableViewDataSource.self))
    }
    
    func testIfViewControllerImplementsTableViewDataSourceMethods() {
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))))
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDataSource.tableView(_:cellForRowAt:))))
    }
    
    func testIfViewControllerImplementsTableViewDelegateMethods() {
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDelegate.scrollViewDidScroll(_:))))
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDelegate.tableView(_:viewForHeaderInSection:))))
    }
    
    func testNumberOfRowsInItemsSectionShouldEqualItemsCount() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        self.sut.sections[section].items = [MyFavoritePlacesModels.DisplayedItem(id: "id")]
        let numberOfRows = self.sut.tableView(self.sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, self.sut.sections[section].items.count)
    }
    
    func testNumberOfSectionsInTableViewShouldEqualSectionsCount() {
        self.loadView()
        let tableView = self.sut.tableView
        let numberOfSections = self.sut.numberOfSections(in: tableView!)
        XCTAssertEqual(numberOfSections, self.sut.sections.count)
    }
    
    func testCellForRowShouldReturnCorrectCellForItems() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        self.sut.sections[section].items = [MyFavoritePlacesModels.DisplayedItem(id: "id")]
        let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: section))
        XCTAssertTrue(cell is MyFavoritePlacesTableViewCell)
    }
    
    func testShouldConfigureItemsTableViewCell() {
        self.loadView()
        
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        let item = MyFavoritePlacesModels.DisplayedItem(id: "id")
        item.title = "Title".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        item.subtitle = "Subtitle".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        item.isLoadingImage = true
        item.image = UIImage()
        item.imageContentMode = .center
        item.imageDominantColor = UIColor.white
        let items = [item]
        self.sut.sections[section].items = items
        
        let tableView = self.sut.tableView
        items.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: index, section: section)) as! MyFavoritePlacesTableViewCell
            XCTAssertNotNil(item.cellInterface)
            XCTAssertNotNil(cell.delegate)
            XCTAssertEqual(cell.itemId, item.id)
            XCTAssertEqual(cell.titleLabel?.attributedText, item.title)
            XCTAssertEqual(cell.subtitleLabel?.attributedText, item.subtitle)
            XCTAssertEqual(cell.placeImageView?.activityIndicatorView?.isHidden, !item.isLoadingImage)
            XCTAssertEqual(cell.placeImageView?.image, item.image)
            XCTAssertEqual(cell.placeImageView?.contentMode, item.imageContentMode)
            XCTAssertEqual(cell.placeImageView?.backgroundColor, item.imageDominantColor)
            XCTAssertTrue(self.interactorSpy.shouldFetchImageCalled)
        }
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewLoadingHeaderFooterViewWhenTheFooterSectionIsLoading() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewLoadingHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewLoadingHeaderFooterViewWhenTheFooterSectionHasNoMoreItems() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = true
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewTitleHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewErrorHeaderFooterViewWhenTheFooterSectionHasError() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = true
        self.sut.sections[section].noMoreItems = false
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewErrorHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnNilWhenTheFooterSectionIsNotLoadingAndHasNoErrorAndHasMoreItems() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = false
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNil(view)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionIsLoading() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionHasNoMoreItems() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = true
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionHasError() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = true
        self.sut.sections[section].noMoreItems = false
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionIsNotLoadingAndHasNoErrorAndHasMoreItems() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = false
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, 0)
    }
    
    func testTableViewViewForFooterInSectionShouldReturnView() {
        self.loadView()
        for (index, _) in self.sut.sections.enumerated() {
            XCTAssertNotNil(self.sut.tableView(self.sut.tableView, viewForFooterInSection: index))
        }
    }
    
    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForItemsSection() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: section)
        XCTAssertEqual(height, MyFavoritePlacesStyle.shared.tableViewModel.itemsSectionFooterHeight)
    }
    
    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForFooterSection() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: section)
        XCTAssertEqual(height, MyFavoritePlacesStyle.shared.tableViewModel.footerSectionFooterHeight)
    }
    
    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForInvalidSection() {
        self.loadView()
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: 2)
        XCTAssertEqual(height, CGFloat.leastNonzeroMagnitude)
    }
    
    // MARK: - Business logic tests
    
    func testShouldFetchItemsWhenTheViewDidLoad() {
        self.loadView()
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    func testShouldFetchItemsWhenScrollViewDidScroll() {
        let threshold: CGFloat = 50
        let contentSizeHeight: CGFloat = 400
        let frameSizeHeight: CGFloat = 100
        let scrollViewSpy = UIScrollViewSpy()
        scrollViewSpy.shouldDecelerate = true
        scrollViewSpy.contentSize.height = contentSizeHeight
        scrollViewSpy.frame.size.height = frameSizeHeight
        scrollViewSpy.contentOffset.y = contentSizeHeight - frameSizeHeight - threshold
        self.sut.scrollViewDidScroll(scrollViewSpy)
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    func testShouldFetchItemsWhenSelectingErrorTitleButtonFromSectionFooterView() {
        self.sut.tableViewErrorHeaderFooterView(view: nil, didSelectTitle: nil)
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    func testTraitCollectionDidChangeShouldAskTheInteractorToFetchItems() {
        let traitCollection = UITraitCollection(preferredContentSizeCategory: UIContentSizeCategory.unspecified)
        self.sut.traitCollectionDidChange(traitCollection)
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    func testUpdateSearchResultsShouldAskTheInteractorToSearchItems() {
        self.sut.updateSearchResults(for: UISearchController())
        XCTAssertTrue(self.interactorSpy.shouldSearchItemsCalled)
    }
    
    func testSearchBarSearchButtonClickedShouldAskTheInteractorToSearchItems() {
        self.sut.searchBarSearchButtonClicked(UISearchBar())
        XCTAssertTrue(self.interactorSpy.shouldSearchItemsCalled)
    }
    
    func testSearchBarTextDidBeginEditingShouldAskTheInteractorToBeginSearchState() {
        self.sut.searchBarTextDidBeginEditing(UISearchBar())
        XCTAssertTrue(self.interactorSpy.shouldBeginSearchStateCalled)
    }
    
    func testSearchBarCancelButtonClickedShouldAskTheInteractorToEndSearchState() {
        self.sut.searchBarCancelButtonClicked(UISearchBar())
        XCTAssertTrue(self.interactorSpy.shouldEndSearchStateCalled)
    }
    
    func testTableViewDidSelectRowAtShouldAskTheInteractorToNavigateToPlaceDetails() {
        self.loadView()
        self.setupSections()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        self.sut.sections[section].items = [MyFavoritePlacesModels.DisplayedItem(id: "id")]
        self.sut.tableView(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: section))
        XCTAssertTrue(self.interactorSpy.shouldNavigateToPlaceDetailsCalled)
    }
    
    func testShouldLoginUserShouldAskTheInteractorToLoginUser() {
        self.sut.shouldLoginUser(user: User(id: "userId"))
        XCTAssertTrue(self.interactorSpy.shouldLoginUserCalled)
    }
    
    func testShouldLogoutUserShouldAskTheInteractorToLogoutUser() {
        self.sut.shouldLogoutUser()
        XCTAssertTrue(self.interactorSpy.shouldLogoutUserCalled)
    }
    
    func testMyFavoritePlacesTableViewCellTouchUpInsideFavoriteButtonForItemIdShouldAskTheInteractorToDeleteItem() {
        self.sut.myFavoritePlacesTableViewCell(nil, touchUpInsideFavorite: nil, forItem: "id")
        XCTAssertTrue(self.interactorSpy.shouldDeleteItemCalled)
    }
    
    func testTableViewCommitEditingStyleForRowAtShouldAskTheInteractorToDeleteItem() {
        self.setupSections()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        self.sut.sections[section].items = [MyFavoritePlacesModels.DisplayedItem(id: "id")]
        self.sut.tableView(self.sut.tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: section))
        XCTAssertTrue(self.interactorSpy.shouldDeleteItemCalled)
    }
    
    // MARK: - Display logic tests
    
    func testDisplayWillFetchItemsShouldUpdateFooterSectionIsLoading() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.displayWillFetchItems()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].isLoading)
    }
    
    func testDisplayWillFetchItemsShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayWillFetchItems()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayDidFetchItemsShouldUpdateFooterSectionIsLoading() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        self.sut.displayDidFetchItems()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].isLoading)
    }
    
    func testDisplayDidFetchItemsShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayDidFetchItems()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayItemsShouldUpdateDisplayedItems() {
        self.setupSections()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = []
        let displayedItems = [MyFavoritePlacesModels.DisplayedItem(id: "id1"), MyFavoritePlacesModels.DisplayedItem(id: "id2")]
        self.sut.displayItems(viewModel: MyFavoritePlacesModels.ItemsPresentation.ViewModel(displayedItems: displayedItems))
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.sections[section].items.count, displayedItems.count)
    }
    
    func testDisplayItemsShouldAskTheTableViewToReloadSections() {
        self.loadView()
        self.setupSections()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = []
        self.sut.displayItems(viewModel: MyFavoritePlacesModels.ItemsPresentation.ViewModel(displayedItems: []))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayNewItemsShouldUpdateDisplayedItems() {
        self.setupSections()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = [MyFavoritePlacesModels.DisplayedItem(id: "id1")]
        let count = self.sut.sections[section].items.count
        let displayedItems = [MyFavoritePlacesModels.DisplayedItem(id: "id2")]
        self.sut.displayNewItems(viewModel: MyFavoritePlacesModels.ItemsPresentation.ViewModel(displayedItems: displayedItems))
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.sections[section].items.count, count + displayedItems.count)
    }
    
    func testDisplayNewItemsShouldAskTheTableViewToInsertRowsInBatchUpdates() {
        self.setupSections()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = [MyFavoritePlacesModels.DisplayedItem(id: "id1")]
        let displayedItems = [MyFavoritePlacesModels.DisplayedItem(id: "id2")]
        self.sut.displayNewItems(viewModel: MyFavoritePlacesModels.ItemsPresentation.ViewModel(displayedItems: displayedItems))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.performBatchUpdatesCalled)
        XCTAssertTrue(tableViewSpy.insertRowsCalled)
    }
    
    func testDisplayResetItemsShouldResetSections() {
        self.sut.sections = []
        self.sut.displayResetItems()
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.sections.count, 2)
    }
    
    func testDisplayResetItemsShouldAskTheTableViewToReloadData() {
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayResetItems()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadDataCalled)
    }
    
    func testDisplayNoMoreItemsShouldUpdateFooterSectionNoMoreItems() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItems = false
        self.sut.displayNoMoreItems(viewModel: MyFavoritePlacesModels.NoMoreItemsPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].noMoreItems)
    }
    
    func testDisplayNoMoreItemsShouldUpdateFooterSectionNoMoreItemsText() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItemsText = nil
        let text = NSAttributedString(string: "No more items", attributes: nil)
        self.sut.displayNoMoreItems(viewModel: MyFavoritePlacesModels.NoMoreItemsPresentation.ViewModel(text: text))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.sections[section].noMoreItemsText)
        XCTAssertEqual(self.sut.sections[section].noMoreItemsText, text)
    }
    
    func testDisplayNoMoreItemsShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayNoMoreItems(viewModel: MyFavoritePlacesModels.NoMoreItemsPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayRemoveNoMoreItemsShouldUpdateFooterSectionNoMoreItems() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItems = true
        self.sut.displayRemoveNoMoreItems()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].noMoreItems)
    }
    
    func testDisplayRemoveNoMoreItemsShouldUpdateFooterSectionNoMoreItemsText() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItemsText = NSAttributedString(string: "No more items", attributes: nil)
        self.sut.displayRemoveNoMoreItems()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.sections[section].noMoreItemsText)
    }
    
    func testDisplayRemoveNoMoreItemsShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayRemoveNoMoreItems()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayEmptyStateShouldUpdateTableViewBackgroundView() {
        self.loadView()
        self.sut.displayEmptyState(viewModel: MyFavoritePlacesModels.EmptyStatePresentation.ViewModel(image: nil, text: nil))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.tableView.backgroundView)
        XCTAssertTrue(self.sut.tableView.backgroundView is EmptyStateView)
    }
    
    func testDisplayRemoveEmptyStateShouldUpdateTableViewBackgroundView() {
        self.loadView()
        self.sut.tableView?.backgroundView = UIView()
        self.sut.displayRemoveEmptyState()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.tableView.backgroundView)
    }
    
    func testDisplayErrorStateShouldUpdateFooterSectionHasError() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].hasError = false
        self.sut.displayErrorState(viewModel: MyFavoritePlacesModels.ErrorStatePresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].hasError)
    }
    
    func testDisplayErrorStateShouldUpdateFooterSectionErrorText() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].errorText = nil
        let text = NSAttributedString(string: "Error", attributes: nil)
        self.sut.displayErrorState(viewModel: MyFavoritePlacesModels.ErrorStatePresentation.ViewModel(text: text))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.sections[section].errorText)
        XCTAssertEqual(self.sut.sections[section].errorText, text)
    }
    
    func testDisplayErrorStateShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayErrorState(viewModel: MyFavoritePlacesModels.ErrorStatePresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayRemoveErrorStateShouldUpdateFooterSectionHasError() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].hasError = true
        self.sut.displayRemoveErrorState()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].hasError)
    }
    
    func testDisplayRemoveErrorStateShouldUpdateFooterSectionErrorText() {
        self.loadView()
        let section = MyFavoritePlacesModels.SectionIndex.footer.rawValue
        self.sut.sections[section].errorText = NSAttributedString(string: "Error", attributes: nil)
        self.sut.displayRemoveErrorState()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.sections[section].errorText)
    }
    
    func testDisplayRemoveErrorStateShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayRemoveErrorState()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayWillFetchImage() {
        let spy = MyFavoritePlacesTableViewCellInterfaceSpy()
        let item = MyFavoritePlacesModels.DisplayedItem(id: "id")
        item.cellInterface = spy
        item.isLoadingImage = false
        self.sut.displayWillFetchImage(viewModel: MyFavoritePlacesModels.ImageFetching.ViewModel(item: item))
        self.waitForMainQueue()
        XCTAssertTrue(item.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayDidFetchImage() {
        let spy = MyFavoritePlacesTableViewCellInterfaceSpy()
        let item = MyFavoritePlacesModels.DisplayedItem(id: "id")
        item.cellInterface = spy
        item.isLoadingImage = true
        self.sut.displayDidFetchImage(viewModel: MyFavoritePlacesModels.ImageFetching.ViewModel(item: item))
        self.waitForMainQueue()
        XCTAssertFalse(item.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayImage() {
        let spy = MyFavoritePlacesTableViewCellInterfaceSpy()
        let item = MyFavoritePlacesModels.DisplayedItem(id: "id")
        item.cellInterface = spy
        item.image = nil
        item.imageContentMode = .center
        let image = UIImage()
        let contentMode = UIView.ContentMode.scaleAspectFill
        self.sut.displayImage(viewModel: MyFavoritePlacesModels.ImagePresentation.ViewModel(item: item, image: image, contentMode: contentMode))
        self.waitForMainQueue()
        XCTAssertEqual(item.image, image)
        XCTAssertEqual(item.imageContentMode, contentMode)
        XCTAssertTrue(spy.setImageCalled)
    }
    
    func testDisplayEnableSearchBar() {
        self.loadView()
        self.sut.navigationItem.searchController?.searchBar.isUserInteractionEnabled = false
        self.sut.navigationItem.searchController?.searchBar.alpha = 0.25
        self.sut.displayEnableSearchBar()
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.navigationItem.searchController?.searchBar.isUserInteractionEnabled, true)
        XCTAssertEqual(self.sut.navigationItem.searchController?.searchBar.alpha, 1.0)
    }
    
    func testDisplayDisableSearchBar() {
        self.loadView()
        self.sut.navigationItem.searchController?.searchBar.isUserInteractionEnabled = true
        self.sut.navigationItem.searchController?.searchBar.alpha = 1
        self.sut.displayDisableSearchBar()
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.navigationItem.searchController?.searchBar.isUserInteractionEnabled, false)
        XCTAssertEqual(self.sut.navigationItem.searchController?.searchBar.alpha, 0.25)
    }
    
    func testDisplayNavigateToPlaceDetailsShouldAskTheRouterToNavigateToPlaceDetails() {
        self.sut.displayNavigateToPlaceDetails(viewModel: MyFavoritePlacesModels.ItemNavigation.ViewModel(place: Place(id: "placeId", location: Location(id: "locationId", latitude: 47, longitude: 27))))
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToPlaceDetailsCalled)
    }
    
    func testDisplayDeleteItemShouldDeleteDisplayedItems() {
        self.setupSections()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        let id = "itemId"
        self.sut.sections[section].items = [MyFavoritePlacesModels.DisplayedItem(id: id)]
        self.sut.displayDeleteItem(viewModel: MyFavoritePlacesModels.ItemDelete.ViewModel(id: id))
        self.waitForMainQueue()
        XCTAssertNil(self.sut.sections[section].items.first(where: { $0.id == id }))
    }
    
    func testDisplayDeleteItemShouldAskTheTableViewToDeleteRowsInBatchUpdates() {
        self.setupSections()
        let section = MyFavoritePlacesModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        let id = "itemId"
        self.sut.sections[section].items = [MyFavoritePlacesModels.DisplayedItem(id: id)]
        self.sut.displayDeleteItem(viewModel: MyFavoritePlacesModels.ItemDelete.ViewModel(id: id))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.performBatchUpdatesCalled)
        XCTAssertTrue(tableViewSpy.deleteRowsCalled)
    }
    
    private func setupSections() {
        self.sut.sections = [MyFavoritePlacesModels.Section(), MyFavoritePlacesModels.Section()]
    }
    
    private func tableViewSpy() -> UITableViewSpy {
        let spy = UITableViewSpy()
        spy.dataSource = self.sut
        spy.delegate = self.sut
        spy.register(MyFavoritePlacesTableViewCell.self, forCellReuseIdentifier: MyFavoritePlacesTableViewCell.defaultReuseIdentifier)
        return spy
    }
}
