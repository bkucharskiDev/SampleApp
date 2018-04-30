//
//  Sensor.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

struct Sensor: Codable {
    
    let id: Int
    let stationId: Int
    let param: Param
    
    struct Param: Codable {
        
        let paramName: String
        let paramFormula: String
        let paramCode: String
        let idParam: Int
    }
    
}
