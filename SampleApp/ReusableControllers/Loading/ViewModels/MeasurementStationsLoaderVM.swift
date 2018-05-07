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
    var handleLoadingFailure: ((Error?) -> Void)?
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func loadResources() {
        dependencies.airQualityService.downloadAllStations { [weak self] (result) in
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
