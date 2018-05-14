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
    
    var testExpectation: XCTestExpectation?
    
    func didUpdateData() {
        testExpectation?.fulfill()
    }
}

class MeasurementStationVMTests: XCTestCase {
    
    let mockedMeasurementStation = MeasurementStation(id: 0, stationName: "MOCKEDSTATION", city: MeasurementStation.City(id: 0, name: "MOCKEDCITY"))
    let mockedAirQualityService = MockedAirQualityService(isDownloadSuccess: true)
    lazy var measurementStationVM = MeasurementStationVM(airQualityService: mockedAirQualityService, measurementStation: mockedMeasurementStation)
    
    func testCity() {
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
        mockedAirQualityService.changeDownloadResult(isSuccess: true)
        
        let testExpectation = XCTestExpectation()
        let mockedDelegate = MockedMeasurementStationVMDelegate()
        mockedDelegate.testExpectation = testExpectation
        measurementStationVM.delegate = mockedDelegate
        
        measurementStationVM.getData()
        wait(for: [testExpectation], timeout: 0.1)
    }
}
