//
//  AppDependency.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
import UIKit

/// All project dependencies
typealias AppDependencies = HasAirQualityService & HasAlertsController

final class AppDependency: AppDependencies {
    
    lazy var alertsController: AlertsControllerProtocol = {
       return AlertsController()
    }()
    
    lazy var airQualityService: AirQualityServiceProtocol = {
        AirQualityService(networkDispatcher: networkDispatcher)
    }()
    
    private lazy var networkDispatcher: Dispatcher = {
        return NetworkDispatcher()
    }()
}
