//
//  MeasurementStationsListVMTest.swift
//  SampleAppTests
//
//  Created by Bartosz Kucharski on 14.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import XCTest
@testable import SampleApp

class MeasurementStationsListVMTest: XCTestCase {
    
    let mockedAirQualityService = MockedAirQualityService(isDownloadSuccess: true)
    lazy var measurementStationListVM = MeasurementStationsListVM(airQualityService: mockedAirQualityService)
    
    func testNumberOfRows() {
        let numberOfRows = measurementStationListVM.numberOfRows(in: 0)
        XCTAssertTrue(numberOfRows == 3)
    }
    
    func testTitleForRowFirstCase() {
        let title = measurementStationListVM.titleForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(title == "STATION0")
    }
    
    func testTitleForRowSecondCase() {
        let title = measurementStationListVM.titleForRow(at: IndexPath(row: 1, section: 0))
        XCTAssertTrue(title == "STATION1")
    }
    
    func testTitleForSection() {
        let sectionTitle = measurementStationListVM.titleForSection(0)
        XCTAssertTrue(sectionTitle == "CITY")
    }
    
    func testSelectRow() {
        let testExpectation = XCTestExpectation()
        measurementStationListVM.handleSelect = { _ in
            testExpectation.fulfill()
        }
        measurementStationListVM.selectRow(at: IndexPath(row: 0, section: 0))
        wait(for: [testExpectation], timeout: 0.1)
    }
}
