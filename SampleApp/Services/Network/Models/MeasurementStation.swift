//
//  MeasurementStation.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

struct MeasurementStation: Codable {
    
    let id: Int
    let stationName: String
    let city: City
    
    struct City: Codable {
        let id: Int
        let name: String
    }
    
}
