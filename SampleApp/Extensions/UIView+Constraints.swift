//
//  UIView+Constraints.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 28.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToCenter(view: UIView, widthRatio: CGFloat = 1.0, heightRatio: CGFloat = 1.0) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
