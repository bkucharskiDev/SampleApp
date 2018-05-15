//
//  MockedAirQualityService.swift
//  SampleAppTests
//
//  Created by Bartosz Kucharski on 14.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

@testable import SampleApp

final class MockedAirQualityService: AirQualityServiceProtocol {
    
    private var isDownloadSuccess: Bool
    
    init(isDownloadSuccess: Bool) {
        self.isDownloadSuccess = isDownloadSuccess
    }
    
    func changeDownloadResult(isSuccess: Bool) {
        isDownloadSuccess = isSuccess
    }
    
    func downloadAllStations(completion: @escaping ((Result<Void>) -> Void)) {
        if isDownloadSuccess {
            completion(.success(()))
        } else {
            completion(.failure(nil))
        }
    }
    
    func getAllStations() -> [MeasurementStation] {
        if isDownloadSuccess {
            let city = MeasurementStation.City(id: 0, name: "CITY")
            return [MeasurementStation(id: 0, stationName: "STATION0", city: city),
                    MeasurementStation(id: 1, stationName: "STATION1", city: city),
                    MeasurementStation(id: 2, stationName: "STATION2", city: city)]
        } else {
            return []
        }
    }
    
    func getStationSensors(stationId: Int, completion: @escaping ((Result<[Sensor]>) -> Void)) {
        if isDownloadSuccess {
            let sensors = [Sensor(id: 0, stationId: 0),
                           Sensor(id: 1, stationId: 1),
                           Sensor(id: 2, stationId: 2),
                           Sensor(id: 3, stationId: 3),
                           Sensor(id: 4, stationId: 4)]
            completion(.success(sensors))
        } else {
            completion(.failure(nil))
        }
    }
    
    func getSensorData(sensorId: Int, completion: @escaping ((Result<SensorData>) -> Void)) {
        if isDownloadSuccess {
            
            let values = [SensorData.Value(date: "DATE0", value: 20),
                          SensorData.Value(date: "DATE1", value: 30),
                          SensorData.Value(date: "DATE2", value: 40),
                          SensorData.Value(date: "DATE3", value: 50)]
            let sensorData = SensorData(key: "KEY0", values: values)
            
            completion(.success(sensorData))
        } else {
            completion(.failure(nil))
        }
    }
}
