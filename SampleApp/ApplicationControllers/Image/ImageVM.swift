//
//  ImageVM.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
import UIKit

final class ImageVM {
    
    typealias Dependencies = HasImageProvider
    
    let dependencies: Dependencies
    let url: URL
    
    init(dependencies: Dependencies, url: URL) {
        self.dependencies = dependencies
        self.url = url
    }
    
    func getImage(completion: (Result<UIImage>) -> Void) {
        dependencies.imageProvider.getImage(url: url, completion: completion)
    }
}
