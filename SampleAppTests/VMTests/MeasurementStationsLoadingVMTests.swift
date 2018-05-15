//
//  MeasurementStationsLoadingVMTests.swift
//  SampleAppTests
//
//  Created by Bartosz Kucharski on 14.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import XCTest
@testable import SampleApp

class MeasurementStationsLoadingVMTests: XCTestCase {
    
    let mockedAirQualityService = MockedAirQualityService(isDownloadSuccess: true)
    lazy var measurementStationsLoadingVM = MeasurementStationsLoadingVM(airQualityService: mockedAirQualityService)
    
    func testLoadResourcesSuccess() {
        let testExpectation = XCTestExpectation()
        measurementStationsLoadingVM.handleLoadingSuccess = {
            testExpectation.fulfill()
        }
        measurementStationsLoadingVM.loadResources()
        wait(for: [testExpectation], timeout: 2.0)
    }
    
    func testLoadResourcesFailure() {
        mockedAirQualityService.changeDownloadResult(isSuccess: false)
        
        let testExpectation = XCTestExpectation()
        measurementStationsLoadingVM.handleLoadingFailure = { _ in
            testExpectation.fulfill()
        }
        measurementStationsLoadingVM.loadResources()
        wait(for: [testExpectation], timeout: 2.0)
    }
}
