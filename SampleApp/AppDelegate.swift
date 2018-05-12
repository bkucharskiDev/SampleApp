//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        return window
    }()
    
    lazy var rootCoordinator: RootCoordinator = {
        let rootCoordinator = RootCoordinator(window: window!, appDependencies: appDependencies)
        return rootCoordinator
    }()
    
    lazy var appDependencies: AppDependencies = {
        return AppDependency()
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        rootCoordinator.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

