//
//  Dispatcher.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 30.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

protocol Dispatcher {
    
    func execute(urlRequest: URLRequest, completion: @escaping ((Result<Data>) -> Void))
}
