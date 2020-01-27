//
//  DetailUnitTests.swift
//  iOS-AssignementTests
//
//  Created by Jérémie Boisjoli on 2020-01-26.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import XCTest
@testable import iOS_Assignement

class DetailUnitTests: XCTestCase {
    
    var detailViewModel: DetailViewModel!
    var detailViewController: DetailViewController!
    var repositoryManager: RepositoryManagerDelegate!
    var networkManager: NetworkManagerDelegate!

    override func setUp() {
        detailViewController = DetailViewController()
        networkManager = NetworkManager()
        repositoryManager = RepositoryManager(networkManagerDelegate: networkManager)
        detailViewModel = DetailViewModel(repositoryManagerDelegate: repositoryManager)
        
        detailViewController.items = []
    }

    override func tearDown() {
        detailViewController = nil
        networkManager = nil
        repositoryManager = nil
        detailViewModel = nil
    }
    
    func testDetailVC_ListVCandListVMShouldNotBeNil() {
        XCTAssertNotNil(detailViewController)
        XCTAssertNotNil(detailViewModel)
    }
    
    func testDetailVC_RepoManagerandNetworkManagerShouldNotBeNil() {
        XCTAssertNotNil(networkManager)
        XCTAssertNotNil(repositoryManager)
    }
    
    func testDetailVC_TableViewShouldNotBeNil() {
        XCTAssertNotNil(detailViewController.viewLayout.tracksTableView)
    }
    
    func testDetailVC_TableViewDelegateandDatasourceNotNil() {
        XCTAssertNotNil(detailViewController.viewLayout.tracksTableView.delegate)
        XCTAssertNotNil(detailViewController.viewLayout.tracksTableView.dataSource)
        
        XCTAssertTrue(detailViewController.viewLayout.tracksTableView.dataSource is DetailViewController)
        XCTAssertTrue(detailViewController.viewLayout.tracksTableView.delegate is DetailViewController)
    }
    
    func testDetailVC_TableViewValidateIfSectionExistsWithItems() {
        detailViewController.items?.append(Items(id: "ABC", snippet: nil, contentDetails: nil))
        detailViewController.items?.append(Items(id: "ABE", snippet: nil, contentDetails: nil))
        detailViewController.items?.append(Items(id: "AFS", snippet: nil, contentDetails: nil))
        detailViewController.items?.append(Items(id: "AQFGC", snippet: nil, contentDetails: nil))
        
        
        detailViewController.viewLayout.tracksTableView.reloadData()
        let sections = detailViewController.viewLayout.tracksTableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(sections, 4)
    }
    
    func testDetailVC_TableViewRowAtIndex_ReturnItemCell() {
        detailViewController.items?.append(Items(id: "AWEFAS", snippet: nil, contentDetails: nil))
        detailViewController.viewLayout.tracksTableView.reloadData()
        
        let cellQueried = detailViewController.viewLayout.tracksTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cellQueried is DetailViewTableViewCell)
    }

}
