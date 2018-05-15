//
//  UIView+Toggle.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 15.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

extension UIView {
    
    func toggle(isVisible: Bool = true) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = isVisible ? 1.0 : 0.0
        })
    }
}
