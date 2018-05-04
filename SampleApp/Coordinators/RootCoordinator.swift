//
//  RootCoordinator.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
import UIKit

final class RootCoordinator: Coordinator {
    
    let window: UIWindow
    let appDependencies: AppDependencies
    
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow, appDependencies: AppDependencies) {
        self.window = window
        self.appDependencies = appDependencies
    }
    
    func start() {
        showLoadingVC()
    }
    
    private func showLoadingVC() {
        let viewModel = MeasurementStationsLoaderVM(dependencies: appDependencies)
        viewModel.handleLoadingSuccess = {
            let vm = MeasurementStationsListVM(dependencies: self.appDependencies)
            let vc = ListTableVC.init(viewModel: vm)
            
            self.window.rootViewController = vc
        }
        
        let vc = LoadingVC(viewModel: viewModel)
        
        window.rootViewController = vc
    }
}
