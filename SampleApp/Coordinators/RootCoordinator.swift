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
        let viewModel = MeasurementStationsLoadingVM(dependencies: appDependencies)
        viewModel.handleLoadingSuccess = { [weak self] in
            self?.showContent()
        }
        
        let vc = LoadingVC(viewModel: viewModel)
        
        viewModel.handleLoadingFailure = { [weak self, weak vc, weak viewModel] error in
            viewModel?.setProgressToZero()
            
            let alertActionHandler = {
                viewModel?.loadResources()
                return
            }
            let alertAction = AlertAction(title: "Try again", actionHandler: alertActionHandler)
            self?.appDependencies.alertsController.showNetworkErrorAlert(error: error,
                                                                         actions: [alertAction],
                                                                         inViewController: vc!)
        }
        
        window.rootViewController = vc
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
