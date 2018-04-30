//
//  LoadingProtocols.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 29.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
import UIKit

protocol LoadingVMProtocol: class {
    
    weak var delegate: LoadingVMDelegate? { get set }
    
    var handleLoadingSuccess: (() -> Void)? { get set }
    var handleLoadingFailure: (() -> Void)? { get set }
    
    func loadResources()
}

protocol LoadingVMDelegate: class {
    
    func didUpdateProgress(_ progress: CGFloat)
}
