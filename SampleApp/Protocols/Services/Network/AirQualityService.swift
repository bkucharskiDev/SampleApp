//
//  AirQualityService.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

final class AirQualityService: AirQualityServiceProtocol {
    
    typealias Dependencies = HasNetworkDispatcher
    
    private let networkDispatcher: Dispatcher
    
    init(networkDispatcher: Dispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    func getAllStations(completion: @escaping ((Result<[MeasurementStation]>) -> Void)) {
        let urlRequest = AirQualityRequest.allStations.asURLRequest()
        
        executeAndDecode(urlRequest: urlRequest, completion: completion)
    }
    
    func getStationSensors(stationId: Int ,completion: @escaping ((Result<Data>) -> Void)) {
        let urlRequest = AirQualityRequest.stationSensors(stationId).asURLRequest()
        
        executeAndDecode(urlRequest: urlRequest, completion: completion)
    }
    
    func getSensorData(sensorId: Int, completion: @escaping ((Result<Data>) -> Void)) {
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