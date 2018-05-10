//
//  AlertsControllerProtocol.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 09.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
import UIKit

typealias AlertAction = (title: String, actionHandler: (() -> Void)?)

protocol AlertsControllerProtocol {
    
    func showAlert(message: String?, actions: [AlertAction], inViewController vc: UIViewController)
    func showNetworkErrorAlert(error: Error?, actions: [AlertAction], inViewController vc: UIViewController)
}
