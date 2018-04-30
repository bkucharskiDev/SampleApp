//
//  URLRequestConvertible.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

protocol URLRequestConvertible {
    
    func asURLRequest() -> URLRequest
}

extension URLRequestConvertible where Self: Request {
    
    func asURLRequest() -> URLRequest {
        var urlString = basePath
            .appending(apiPath)
            .appending(path)
        
        if
            let parameters = parameters, parameters.count > 0 {
            
            urlString.append("?")
            parameters.forEach {
                urlString.append("/\($0.key)=\($0.value)")
            }
        }
        
        guard let url = URL(string: urlString) else {
            fatalError("Could not initialize URL with path: \(urlString)")
        }
        
        var urlRequest = URLRequest(url: url)
        
        headers?.forEach {
            urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
        }
        
        return urlRequest
    }
}
