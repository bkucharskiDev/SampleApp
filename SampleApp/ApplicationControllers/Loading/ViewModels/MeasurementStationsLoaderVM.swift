//
//  MeasurementStationsLoaderVM.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 28.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

final class MeasurementStationsLoaderVM: LoadingVMProtocol {
    
    typealias Dependencies = HasAirQualityService
    
    weak var delegate: LoadingVMDelegate?
    
    let dependencies: Dependencies
    
    var handleLoadingSuccess: (() -> Void)?
    var handleLoadingFailure: (() -> Void)?
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func loadResources() {
        dependencies.airQualityService.getAllStations { [weak self] (result) in
            switch result {
            case .success(let stations):
                print(stations)
                self?.handleLoadingSuccess?()
                self?.delegate?.didUpdateProgress(0.75)
            case .failure(let error):
                print(error)
                self?.handleLoadingFailure?()
            }
        }
    }
}
