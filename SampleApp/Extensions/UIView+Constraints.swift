//
//  UIView+Constraints.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 28.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToFit(view: UIView) {
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinToFit(view: UIView, with margins: UIEdgeInsets) {
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: margins.right).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: margins.top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margins.bottom).isActive = true
    }
    
    func pinToCenter(view: UIView, widthRatio: CGFloat = 1.0, heightRatio: CGFloat = 1.0) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func pinToCenter(view: UIView, width: CGFloat, height: CGFloat) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
