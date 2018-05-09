//
//  AlertsController.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 09.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

final class AlertsController: AlertsControllerProtocol {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showNetworkErrorAlert(error: Error?, actions: [AlertAction]) {
        showAlert(message: "Network error appeared \n" +
            (error?.localizedDescription ?? ""), actions: actions)
    }
    
    func showAlert(message: String?, actions: [AlertAction]) {
        
        var alertActions: [UIAlertAction] = []
        
        // In case there isn't any action
        if actions.isEmpty {
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertActions.append(defaultAction)
        }
        
        let alertController = UIAlertController(title: "Ooops!", message: message, preferredStyle: .alert)
        actions.forEach { alertAction in
            
            let action = UIAlertAction(title: alertAction.title, style: .default, handler: { _ in
                alertAction.actionHandler?()
            })
            alertActions.append(action)
        }
        
        alertActions.forEach { alertController.addAction($0) }
        
        window.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
