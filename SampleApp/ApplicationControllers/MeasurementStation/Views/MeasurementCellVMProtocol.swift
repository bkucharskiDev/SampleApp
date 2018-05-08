//
//  MeasurementCellVMProtocol.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 08.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

protocol MeasurementCellVMProtocol {
    
    var key: String { get }
    var date: String { get }
    var value: String { get }
}
