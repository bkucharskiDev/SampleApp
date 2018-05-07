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
        vm.handleSelect = { measurementStation in
            
        }
        let vc = ListTableVC(viewModel: vm)
        let navigationController = UINavigationController(rootViewController: vc)
        
        window.rootViewController = navigationController
    }
}
