//
//  HasImageProvider.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
import UIKit

protocol HasImageProvider {
    
    var imageProvider: ImageProviderProtocol { get }
}

protocol ImageProviderProtocol {
    
    func getImage(url: URL, completion: ((Result<UIImage>) -> Void))
}
