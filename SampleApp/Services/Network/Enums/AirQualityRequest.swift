//
//  AirQualityRequest.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

enum AirQualityRequest: Request, URLRequestConvertible {
    
    typealias StationId = Int
    typealias SensorId = Int
    
    case allStations
    case stationSensors(StationId)
    case sensorData(SensorId)
    
    var basePath: String {
        switch self {
        case .allStations, .stationSensors, .sensorData:
            return "http://api.gios.gov.pl"
        }
    }
    
    var apiPath: String {
        switch self {
        case .allStations, .stationSensors, .sensorData:
            return "/pjp-api/rest"
        }
    }
    
    var path: String {
        switch self {
        case .allStations:
            return "/station/findAll"
        case .stationSensors(let stationId):
            return "/station/sensors/\(stationId)"
        case .sensorData(let sensorId):
            return "/data/getData/\(sensorId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allStations, .sensorData, .stationSensors:
            return .get
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .allStations, .stationSensors, .sensorData:
            return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .allStations, .stationSensors, .sensorData:
            return nil
        }
    }
}

