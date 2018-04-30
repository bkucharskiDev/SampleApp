//
//  AirQualityService.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

final class AirQualityService {
    
    typealias Dependencies = HasNetworkDispatcher
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getAllStations(completion: @escaping ((Result<Data>) -> Void)) {
        let urlRequest = AirQualityRequest.allStations.asURLRequest()
        
        dependencies.networkDispatcher.execute(urlRequest: urlRequest) { (result) in
            completion(result)
        }
    }
    
    func getStationSensors(stationId: Int ,completion: @escaping ((Result<Data>) -> Void)) {
        let urlRequest = AirQualityRequest.stationSensors(stationId).asURLRequest()
        
        dependencies.networkDispatcher.execute(urlRequest: urlRequest) { (result) in
            completion(result)
        }
    }
    
    func getSensorData(sensorId: Int, completion: @escaping ((Result<Data>) -> Void)) {
        let urlRequest = AirQualityRequest.sensorData(sensorId).asURLRequest()
        
        dependencies.networkDispatcher.execute(urlRequest: urlRequest) { (result) in
            completion(result)
        }
    }
}
