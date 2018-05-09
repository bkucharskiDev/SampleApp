//
//  HasAlertsController.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 09.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

protocol HasAlertsController {
    
    var alertsController: AlertsControllerProtocol { get }
}
