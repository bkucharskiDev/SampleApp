//
//  MeasurementStationVMTests.swift
//  SampleAppTests
//
//  Created by Bartosz Kucharski on 14.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import XCTest
@testable import SampleApp

class MockedMeasurementStationVMDelegate: MeasurementStationVMDelegate {
    
    weak var testExpectation: XCTestExpectation?
    
    func didUpdateData() {
        testExpectation?.fulfill()
    }
    
    func didStartUpdatingData() { }
    func didFailUpdatingData() { }
}

class MeasurementStationVMTests: XCTestCase {
    
    let mockedMeasurementStation = MeasurementStation(id: 0, stationName: "MOCKEDSTATION", city: MeasurementStation.City(id: 0, name: "MOCKEDCITY"))
    let mockedAirQualityService = MockedAirQualityService(isDownloadSuccess: true)
    let mockedDelegate = MockedMeasurementStationVMDelegate()
    lazy var measurementStationVM = MeasurementStationVM(airQualityService: mockedAirQualityService, measurementStation: mockedMeasurementStation)
    
    override func setUp() {
        mockedAirQualityService.changeDownloadResult(isSuccess: true)
    }
    
    func testCityName() {
        let cityName = measurementStationVM.city
        XCTAssertTrue(cityName == "MOCKEDCITY")
    }
    
    func testStationName() {
        let stationName = measurementStationVM.stationName
        XCTAssertTrue(stationName == "MOCKEDSTATION")
    }
    
    func testGetDataFailure() {
        mockedAirQualityService.changeDownloadResult(isSuccess: false)
        
        let testExpectation = XCTestExpectation()
        measurementStationVM.handleDownloadFailure = { _ in
            testExpectation.fulfill()
        }
        measurementStationVM.getData()
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testGetDataSuccess() {
        let testExpectation = XCTestExpectation()
        mockedDelegate.testExpectation = testExpectation
        measurementStationVM.delegate = mockedDelegate
        
        measurementStationVM.getData()
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testNumberOfRows() {
        measurementStationVM.getData()
        let numberOfRows = measurementStationVM.numberOfRows
        XCTAssertTrue(numberOfRows > 0)
    }
}
