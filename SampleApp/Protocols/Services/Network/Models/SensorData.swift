//
//  SensorData.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

struct SensorData: Codable {
    
    let key: String
    let values: [Value]
    
    struct Value: Codable {
        let date: String
        let value: Double
    }
}
