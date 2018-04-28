//
//  CircleProgressViewController.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 28.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

class CircleProgressViewController: UIViewController {
    
    private var circleProgressView: CircleProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - UI
extension CircleProgressViewController {
    
    private func buildUI() {
        view.backgroundColor = .black
        setupCircleProgressView()
        
        setupConstraints()
    }
    
    private func setupCircleProgressView() {
        circleProgressView = CircleProgressView(frame: .zero)
        view.addSubview(circleProgressView)
    }
    
    private func setupConstraints() {
        
    }
}



