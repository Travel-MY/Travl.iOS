//
//  NetworkManagerTest.swift
//  TravlTests
//
//  Created by Ikmal Azman on 19/11/2021.
//

import XCTest
@testable import Travl_iOS

class download_data_from_network_manager: XCTestCase {


    var urlSession : URLSession?
    var networkManager : NetworkManager?
    
    override func setUp() {
        urlSession = URLSession.shared
        networkManager = NetworkManager()
    }
    
    override  func tearDown() {
        urlSession = nil
        networkManager = nil
    }
    
    func test_should_download_locations() {
        let exp = expectation(description: "Data downloaded for locations")
        networkManager?.getLocations(completed: { response in
            switch response {
            case .success(let locations):
                XCTAssertNotNil(locations, "No data for locations  downloaded ")
                exp.fulfill()
            case .failure(let error):
                XCTAssertNil(error, "No data for locations  downloaded")
            }
        })
        wait(for: [exp], timeout: 10.0)
    }
    
    func test_should_download_itenaries() {
        let exp = expectation(description: "Data downloaded for itenaries")
        networkManager?.getItenaries(for: "Kuala-Lumpur", completed: { response in
            switch response {
            case .success(let itenaries):
                XCTAssertNotNil(itenaries, "No data for itenaries  downloaded")
                exp.fulfill()
            case .failure(let error):
                XCTAssertNil(error, "No data for itenaries  downloaded")
            }
        })
        wait(for: [exp], timeout: 10.0)
    }

}
