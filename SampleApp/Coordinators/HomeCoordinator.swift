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
    
    private let dependencies: AppDependencies
    private let window: UIWindow
    
    init(dependencies: AppDependencies, window: UIWindow) {
        self.dependencies = dependencies
        self.window = window
    }
    
    func start() {
        showMeasurementStationsList()
    }
    
    private func showMeasurementStationsList() {
        let vm = MeasurementStationsListVM(dependencies: dependencies)
        
        vm.handleSelect = { [weak self] measurementStation in
            
            guard let `self` = self else { return }
            
            let vm = MeasurementStationVM(dependencies: self.dependencies,
                                          measurementStation: measurementStation)
            
            vm.handleDownloadFailure = { [weak self] error in
                let alertActionHandler = {
                    vm.getData()
                }
                let alertAction = AlertAction(title: "Try again", actionHandler: alertActionHandler)
                let cancelAlertAction = AlertAction(title: "Cancel", actionHandler: nil)
                self?.dependencies.alertsController.showNetworkErrorAlert(error: error, actions: [alertAction, cancelAlertAction])
            }
            
            let vc = MeasurementStationVC(viewModel: vm)
            
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
