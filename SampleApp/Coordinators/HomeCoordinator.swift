//
//  HomeCoordinator.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 07.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let dependencies: AppDependency
    private let window: UIWindow
    
    init(dependencies: AppDependency, window: UIWindow) {
        self.dependencies = dependencies
        self.window = window
    }
    
    func start() {
        showMeasurementStationsList()
    }
    
    private func showMeasurementStationsList() {
        let vm = MeasurementStationsListVM(airQualityService: dependencies.airQualityService)
        
        vm.handleSelect = { [weak self] measurementStation in
            
            guard let `self` = self else { return }
            
            let vm = MeasurementStationVM(airQualityService: self.dependencies.airQualityService,
                                          measurementStation: measurementStation)
            
            let vc = MeasurementStationVC(viewModel: vm)
            
            vm.handleDownloadFailure = { [weak self, weak vc, weak vm] error in
                let alertActionHandler = {
                    vm?.getData()
                    return
                }
                let alertAction = AlertAction(title: "Try again".localized, actionHandler: alertActionHandler)
                let cancelAlertAction = AlertAction(title: "Cancel".localized, actionHandler: nil)
                
                guard let vc = vc else { return }
                
                self?.dependencies.alertsController.showNetworkErrorAlert(error: error, actions: [alertAction, cancelAlertAction], inViewController: vc)
            }
            
            guard let navigationController = self.window.rootViewController as? UINavigationController else {
                assertionFailure("Root view controller is not UINavigationController")
                return
            }
            
            navigationController.pushViewController(vc, animated: true)
        }
        let vc = ListTableVC(viewModel: vm)
        
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
}
