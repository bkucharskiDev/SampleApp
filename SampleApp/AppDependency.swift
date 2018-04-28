//
//  AppDependency.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
import UIKit

final class AppDependency: AppDependencies {
    
    lazy var imageProvider: ImageProviderProtocol = {
        return ImageProvider()
    }()
}


final class ImageProvider: ImageProviderProtocol {
    
    func getImage(url: URL, completion: ((Result<UIImage>) -> Void)) {
        completion(.failure(nil))
    }
}
