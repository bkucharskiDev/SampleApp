//
//  AppDependency.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
import UIKit

final class AppDependency: AppDependencies {
    
    lazy var networkDispatcher: Dispatcher = {
        return NetworkDispatcher()
    }()
}
