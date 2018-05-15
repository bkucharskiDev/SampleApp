//
//  AirQualityServiceTest.swift
//  SampleAppTests
//
//  Created by Bartosz Kucharski on 15.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import XCTest
@testable import SampleApp

class AirQualityServiceTest: XCTestCase {
    
    let mockedDispatcher = MockedDispatcher()
    lazy var airQualityService = AirQualityService(networkDispatcher: mockedDispatcher)
    
    override func setUp() {
        mockedDispatcher.isDownloadSuccess = true
        mockedDispatcher.isJsonCorrect = true
    }
    
    func testDownloadAllStations() {
        let testExpectation = XCTestExpectation()
        airQualityService.downloadAllStations { (result) in
            switch result {
            case .success:
                testExpectation.fulfill()
            default:
                break
            }
        }
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testGetAllStations() {
        airQualityService.downloadAllStations(completion: { _ in
            let allStations = self.airQualityService.getAllStations()
            XCTAssertTrue(!allStations.isEmpty)
        })
    }
    
    func testGetStationSensors() {
        let testExpectation = XCTestExpectation()
        airQualityService.getStationSensors(stationId: 0, completion: { (result) in
            switch result {
            case .success:
                testExpectation.fulfill()
            default:
                break
            }
        })
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testGetSensorData() {
        let testExpectation = XCTestExpectation()
        airQualityService.getSensorData(sensorId: 0, completion: { (result) in
            switch result {
            case .success:
                testExpectation.fulfill()
            default:
                break
            }
        })
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testDownloadFailure() {
        mockedDispatcher.isDownloadSuccess = false
        
        let testExpectation = XCTestExpectation()
        airQualityService.downloadAllStations { (result) in
            switch result {
            case .failure:
                testExpectation.fulfill()
            default:
                break
            }
        }
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testWrongJson() {
        mockedDispatcher.isJsonCorrect = false
        
        let testExpectation = XCTestExpectation()
        airQualityService.downloadAllStations { (result) in
            switch result {
            case .failure:
                testExpectation.fulfill()
            default:
                break
            }
        }
        wait(for: [testExpectation], timeout: 0.1)
    }
}
