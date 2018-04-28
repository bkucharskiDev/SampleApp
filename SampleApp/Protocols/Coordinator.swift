//
//  Coordinator.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func appendChildCoordinator(_ childCoordinator: Coordinator)
    func removeChildCoordinator(_ childCoordinator: Coordinator)
}

extension Coordinator {
    
    func appendChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}
