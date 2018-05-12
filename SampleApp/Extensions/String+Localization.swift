//
//  String+Localization.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 12.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
