//
//  Result.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error?)
}
