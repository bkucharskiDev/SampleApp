//
//  MeasurementStationsLoadingVM.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 28.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

final class MeasurementStationsLoadingVM: LoadingVMProtocol {
    
    weak var delegate: LoadingVMDelegate?
    
    private let airQualityService: AirQualityServiceProtocol
    
    var handleLoadingSuccess: (() -> Void)?
    var handleLoadingFailure: ((Error?) -> Void)?
    
    init(airQualityService: AirQualityServiceProtocol) {
        self.airQualityService = airQualityService
    }
    
    func loadResources() {
        airQualityService.downloadAllStations { [weak self] (result) in
            switch result {
            case .success:
                self?.delegate?.didUpdateProgress(1.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    self?.handleLoadingSuccess?()
                })
            case .failure(let error):
                self?.handleLoadingFailure?(error)
            }
        }
    }
}
