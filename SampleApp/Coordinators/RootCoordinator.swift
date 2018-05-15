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
    let appDependencies: AppDependency
    
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow, appDependencies: AppDependency) {
        self.window = window
        self.appDependencies = appDependencies
    }
    
    func start() {
        showLoadingVC()
    }
    
    private func showLoadingVC() {
        let viewModel = MeasurementStationsLoadingVM(airQualityService: appDependencies.airQualityService)
        viewModel.handleLoadingSuccess = { [weak self] in
            self?.showContent()
        }
        
        let vc = LoadingVC(viewModel: viewModel)
        
        viewModel.handleLoadingFailure = { [weak self, weak vc, weak viewModel] error in
            guard let vc = vc, let vm = viewModel else { return }
            
            self?.showNetworkAlert(vc: vc, vm: vm, error: error)
        }
        
        window.rootViewController = vc
    }
    
    //MARK: Helpers
    private func showNetworkAlert(vc: UIViewController, vm: MeasurementStationsLoadingVM, error: Error?) {
        vm.setProgressToZero()
        
        let alertActionHandler = {
            vm.loadResources()
        }
        
        let alertAction = AlertAction(title: "Try again".localized, actionHandler: alertActionHandler)
        appDependencies.alertsController.showNetworkErrorAlert(error: error,
                                                                     actions: [alertAction],
                                                                     inViewController: vc)
    }
}

// MARK: - ContentCoordinator
extension RootCoordinator {
    
    private func showContent() {
        let contentCoordinator = HomeCoordinator(dependencies: appDependencies, window: window)
        contentCoordinator.start()
        
        appendChildCoordinator(contentCoordinator)
    }
}
