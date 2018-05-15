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
            self?.showMeasurementStationVC(measurementStation: measurementStation)
        }
        let vc = ListTableVC(viewModel: vm)
        
        window.rootViewController = UINavigationController(rootViewController: vc)
    }
    
    private func showMeasurementStationVC(measurementStation: MeasurementStation) {
        
        let vm = MeasurementStationVM(airQualityService: dependencies.airQualityService,
                                      measurementStation: measurementStation)
        
        let vc = MeasurementStationVC(viewModel: vm)
        
        vm.handleDownloadFailure = { [weak self, weak vc, weak vm] error in
            
            guard let vc = vc, let vm = vm else { return }
            
            self?.showNetworkAlert(vc: vc, vm: vm, error: error)
        }
        
        guard let navigationController = window.rootViewController as? UINavigationController else {
            assertionFailure("Root view controller is not UINavigationController")
            return
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    //MARK: Helpers
    private func showNetworkAlert(vc: UIViewController, vm: MeasurementStationVM, error: Error?) {
        let alertActionHandler = {
            vm.getData()
        }
        let alertAction = AlertAction(title: "Try again".localized, actionHandler: alertActionHandler)
        let cancelAlertAction = AlertAction(title: "Cancel".localized, actionHandler: nil)
        
        dependencies.alertsController.showNetworkErrorAlert(error: error, actions: [alertAction, cancelAlertAction], inViewController: vc)
    }
}
