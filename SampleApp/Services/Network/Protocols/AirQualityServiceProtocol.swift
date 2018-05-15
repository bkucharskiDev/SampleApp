//
//  AirQualityServiceProtocol.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

protocol AirQualityServiceProtocol {
    
    func getAllStations() -> [MeasurementStation]
    func downloadAllStations(completion: @escaping ((Result<Void>) -> Void))
    func getStationSensors(stationId: Int ,completion: @escaping ((Result<[Sensor]>) -> Void))
    func getSensorData(sensorId: Int, completion: @escaping ((Result<SensorData>) -> Void))
}
