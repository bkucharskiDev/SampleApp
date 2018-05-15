//
//  CircleProgressView.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 28.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

final class CircleProgressView: UIView {
    
    var progress: CGFloat = 0.0 {
        didSet {
            if progress > 1.0 || progress < 0.0 { progress = 0.0 }
            shapeLayer.strokeEnd = progress
        }
    }
    
    var lineWidth: CGFloat = 5.0 {
        didSet {
            shapeLayer.lineWidth = lineWidth
        }
    }
    
    private var shapeLayer: CAShapeLayer
    
    override init(frame: CGRect) {
        shapeLayer = CAShapeLayer()
        super.init(frame: frame)
        
        setupShapeLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        shapeLayer = CAShapeLayer()
        super.init(coder: aDecoder)
        
        setupShapeLayer()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let center = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        let circularPath = UIBezierPath(arcCenter: center, radius: rect.width / 2.0, startAngle: -CGFloat.pi/2.0, endAngle: 3 * CGFloat.pi/2.0, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
    }
    
    private func setupShapeLayer() {
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(shapeLayer)
    }
}

