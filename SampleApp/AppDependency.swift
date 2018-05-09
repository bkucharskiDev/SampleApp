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
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // Public dependencies
    
    lazy var alertsController: AlertsControllerProtocol = {
       return AlertsController(window: window)
    }()
    
    lazy var airQualityService: AirQualityServiceProtocol = {
        AirQualityService(networkDispatcher: networkDispatcher)
    }()
    
    // Private dependencies
    
    private lazy var networkDispatcher: Dispatcher = {
        return NetworkDispatcher()
    }()
}
