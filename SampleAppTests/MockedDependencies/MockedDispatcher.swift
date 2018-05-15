//
//  MockedDispatcher.swift
//  SampleAppTests
//
//  Created by Bartosz Kucharski on 15.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
@testable import SampleApp

class MockedDispatcher: Dispatcher {
    
    var isDownloadSuccess = true
    var isJsonCorrect = true
    
    func execute(urlRequest: URLRequest, completion: @escaping ((Result<Data>) -> Void)) {
        
        if !isDownloadSuccess {
            completion(.failure(nil))
            return
        }
        else if !isJsonCorrect {
            let jsonURL = Bundle(for: MockedDispatcher.self).url(forResource: "wrongJson", withExtension: "json")!
            let jsonData = try! Data(contentsOf: jsonURL)
            completion(.success(jsonData))
            return
        }
    
        let urlString = urlRequest.url!.absoluteString
        
        if urlString.range(of: "/station/findAll") != nil {
            let jsonURL = Bundle(for: MockedDispatcher.self).url(forResource: "measurementStations", withExtension: "json")!
            let jsonData = try! Data(contentsOf: jsonURL)
            completion(.success(jsonData))
        }
            
        else if urlString.range(of: "/station/sensors/") != nil {
            let jsonURL = Bundle(for: MockedDispatcher.self).url(forResource: "stationSensors", withExtension: "json")!
            let jsonData = try! Data(contentsOf: jsonURL)
            completion(.success(jsonData))
        }
            
        else if urlString.range(of: "/data/getData/") != nil {
            let jsonURL = Bundle(for: MockedDispatcher.self).url(forResource: "sensorData", withExtension: "json")!
            let jsonData = try! Data(contentsOf: jsonURL)
            completion(.success(jsonData))
        }
            
        else {
            assertionFailure("Unrecognized URLRequest")
        }
    }
}
