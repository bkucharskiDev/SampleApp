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
            [shapeLayer, fullCircleLayer].forEach { $0.lineWidth = lineWidth }
        }
    }
    
    private var shapeLayer: CAShapeLayer
    private var fullCircleLayer: CAShapeLayer
    
    
    override init(frame: CGRect) {
        shapeLayer = CAShapeLayer()
        fullCircleLayer = CAShapeLayer()
        super.init(frame: frame)
        
        setupLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        shapeLayer = CAShapeLayer()
        fullCircleLayer = CAShapeLayer()
        super.init(coder: aDecoder)
        
        setupLayers()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let center = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        let circularPath = UIBezierPath(arcCenter: center, radius: rect.width / 2.0, startAngle: -CGFloat.pi/2.0, endAngle: 3 * CGFloat.pi/2.0, clockwise: true)
        
        fullCircleLayer.path = circularPath.cgPath
        shapeLayer.path = circularPath.cgPath
    }
    
    func setupLayers() {
        [fullCircleLayer, shapeLayer].forEach {
            $0.strokeStart = 0
            $0.strokeEnd = 0
            $0.lineWidth = lineWidth
            $0.strokeColor = UIColor.white.cgColor
            $0.fillColor = UIColor.clear.cgColor
        }
        
        fullCircleLayer.strokeEnd = 1.0
        fullCircleLayer.strokeColor = UIColor.red.cgColor
        
        layer.addSublayer(fullCircleLayer)
        layer.addSublayer(shapeLayer)
    }
}
