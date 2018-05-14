//
//  AirQualityService.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

final class AirQualityService: AirQualityServiceProtocol {
    
    //Cache
    private var allMeasurementStations: [MeasurementStation] = []
    
    private let networkDispatcher: Dispatcher
    
    init(networkDispatcher: Dispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    func downloadAllStations(completion: @escaping ((Result<Void>) -> Void)) {
        let urlRequest = AirQualityRequest.allStations.asURLRequest()
        
        let completion: (Result<[MeasurementStation]>) -> Void = { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let stations):
                self.allMeasurementStations = stations
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        executeAndDecode(urlRequest: urlRequest, completion: completion)
    }
    
    func getAllStations() -> [MeasurementStation] {
        return allMeasurementStations
    }
    
    func getStationSensors(stationId: Int ,completion: @escaping ((Result<[Sensor]>) -> Void)) {
        let urlRequest = AirQualityRequest.stationSensors(stationId).asURLRequest()
        
        executeAndDecode(urlRequest: urlRequest, completion: completion)
    }
    
    func getSensorData(sensorId: Int, completion: @escaping ((Result<SensorData>) -> Void)) {
        let urlRequest = AirQualityRequest.sensorData(sensorId).asURLRequest()
        
        executeAndDecode(urlRequest: urlRequest, completion: completion)
    }
    
    //MARK: Helpers
    private func executeAndDecode<T: Decodable>(urlRequest: URLRequest, completion: @escaping ((Result<T>) -> Void)) {
        
        networkDispatcher.execute(urlRequest: urlRequest) { response in
            
            let result: Result<T>
            
            switch response {
            case .success(let data):
                do {
                    let values = try JSONDecoder().decode(T.self, from: data)
                    result = .success(values)
                } catch {
                    result = .failure(error)
                }
            case .failure(let error):
                result = .failure(error)
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
}
