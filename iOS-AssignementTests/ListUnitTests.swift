//
//  ListUnitTests.swift
//  iOS-AssignementTests
//
//  Created by Jérémie Boisjoli on 2020-01-25.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import XCTest
@testable import iOS_Assignement

class ListUnitTests: XCTestCase {
    
    var listViewModel: ListViewModel!
    var listViewController: ListViewController!
    var repositoryManager: RepositoryManagerDelegate!
    var networkManager: NetworkManagerDelegate!
   
    override func setUp() {
        listViewController = ListViewController()
        networkManager = NetworkManager()
        repositoryManager = RepositoryManager(networkManagerDelegate: networkManager)
        listViewModel = ListViewModel(repositoryManagerDelegate: repositoryManager)
        
        listViewController.items = []
    }

    override func tearDown() {
        listViewController = nil
        networkManager = nil
        repositoryManager = nil
        listViewModel = nil
    }

    func testListVC_ListVCandListVMShouldNotBeNil() {
        XCTAssertNotNil(listViewController)
        XCTAssertNotNil(listViewModel)
    }
    
    func testListVC_RepoManagerandNetworkManagerShouldNotBeNil() {
        XCTAssertNotNil(networkManager)
        XCTAssertNotNil(repositoryManager)
    }
    
    func testListVC_TableViewShouldNotBeNil() {
        XCTAssertNotNil(listViewController.viewLayout.listTableView)
    }
    
    func testListVC_TableViewDelegateandDatasourceNotNil() {
        XCTAssertNotNil(listViewController.viewLayout.listTableView.delegate)
        XCTAssertNotNil(listViewController.viewLayout.listTableView.dataSource)
        
        XCTAssertTrue(listViewController.viewLayout.listTableView.dataSource is ListViewController)
        XCTAssertTrue(listViewController.viewLayout.listTableView.delegate is ListViewController)
    }
    
    func testListVC_TableViewValidateIfSectionExistsWithItems() {
        listViewController.items?.append(Items(id: "1", snippet: nil, contentDetails: nil))
        listViewController.items?.append(Items(id: "2", snippet: nil, contentDetails: nil))
        listViewController.items?.append(Items(id: "3", snippet: nil, contentDetails: nil))
        listViewController.items?.append(Items(id: "4", snippet: nil, contentDetails: nil))
        listViewController.items?.append(Items(id: "5", snippet: nil, contentDetails: nil))
        
        
        listViewController.viewLayout.listTableView.reloadData()
        let sections = listViewController.viewLayout.listTableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(sections, 5)
    }
    
    func testListVC_TableViewRowAtIndex_ReturnItemCell() {
        listViewController.items?.append(Items(id: "1", snippet: nil, contentDetails: nil))
        listViewController.viewLayout.listTableView.reloadData()
        
        let cellQueried = listViewController.viewLayout.listTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cellQueried is ListViewCell)
    }
}
