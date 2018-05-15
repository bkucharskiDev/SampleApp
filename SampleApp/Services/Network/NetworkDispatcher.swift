//
//  NetworkDispatcher.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

final class NetworkDispatcher: NSObject, Dispatcher {
    
    private lazy var defaultUrlSession = URLSession(configuration: .default)
    
    private let dispatchQueue = DispatchQueue(label: "NetworkDispatcherQueue")
    
    func execute(urlRequest: URLRequest, completion: @escaping ((Result<Data>) -> Void)) {
        
        let dataTask = defaultUrlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                completion(.success(data))
            }
        }
        
        dispatchQueue.async {
            dataTask.resume()
        }
    }
}
