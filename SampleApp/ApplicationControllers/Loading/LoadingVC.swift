//
//  LoadingVC.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 28.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

final class LoadingVC: UIViewController {
    
    private var circleProgressView: CircleProgressView!
    private var loadingDataLabel: UILabel!
    
    private let viewModel: LoadingVMProtocol
    
    init(viewModel: LoadingVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        viewModel.loadResources()
    }
    
    private func setup() {
        buildUI()
    }
}

// MARK: - UI
extension LoadingVC {
    
    private func buildUI() {
        view.backgroundColor = .black
        setupCircleProgressView()
        setupLoadingDataLabel()
        
        setupConstraints()
    }
    
    private func setupCircleProgressView() {
        circleProgressView = CircleProgressView(frame: .zero)
        view.addSubview(circleProgressView)
    }
    
    private func setupLoadingDataLabel() {
        loadingDataLabel = UILabel()
        loadingDataLabel.textColor = .white
        loadingDataLabel.text = "Loading data..."
        
        view.addSubview(loadingDataLabel)
    }
    
    private func setupConstraints() {
        circleProgressView.translatesAutoresizingMaskIntoConstraints = false
        circleProgressView.pinToCenter(view: view)
        circleProgressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        circleProgressView.heightAnchor.constraint(equalTo: circleProgressView.widthAnchor).isActive = true
        
        loadingDataLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingDataLabel.topAnchor.constraint(equalTo: circleProgressView.bottomAnchor, constant: 10).isActive = true
    }
}

// MARK: - LoadingVMDelegate
extension LoadingVC: LoadingVMDelegate {
    
    func didUpdateProgress(_ progress: CGFloat) {
        circleProgressView.progress = progress
    }
}
