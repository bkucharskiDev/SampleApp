//
//  MeasurementStationsLoaderVM.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 28.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

final class MeasurementStationsLoaderVM: LoadingVMProtocol {
    
    weak var delegate: LoadingVMDelegate?
    
    var handleLoadingSuccess: (() -> Void)?
    var handleLoadingFailure: (() -> Void)?
    
    func loadResources() {
        delegate?.didUpdateProgress(1.0)
        handleLoadingSuccess?()
    }
}
