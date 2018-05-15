//
//  MeasurementStationVC.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 07.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

class MeasurementStationVC: UIViewController, Identifiable {
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var stationNameLabel: UILabel!
    @IBOutlet private weak var measurementTableView: UITableView!
    @IBOutlet private weak var loadingView: UIView!
    
    private let viewModel: MeasurementStationVM

    init(viewModel: MeasurementStationVM) {
        self.viewModel = viewModel
        
        super.init(nibName: MeasurementStationVC.identifier, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        navigationController?.isNavigationBarHidden = false
        
        setupLabels()
        setupTableView()
        setupViewModel()
    }
    
    private func setupLabels() {
        cityLabel.text = viewModel.city
        stationNameLabel.text = viewModel.stationName
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        
        viewModel.getData()
    }
    
    private func setupTableView() {
        measurementTableView.separatorStyle = .none
        measurementTableView.register(UINib(nibName: MeasurementCell.identifier, bundle: nil), forCellReuseIdentifier: MeasurementCell.identifier)
    }
}

// MARK: - UITableViewDataSource
extension MeasurementStationVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(at: indexPath) as MeasurementCell
        cell.setupWith(viewModel.cellVM(at: indexPath))
        return cell
    }
}

// MARK: - MeasurementStationVMDelegate
extension MeasurementStationVC: MeasurementStationVMDelegate {
    
    func didStartUpdatingData() {
        loadingView.toggle(isVisible: true)
    }
    
    func didFailUpdatingData() {
        loadingView.toggle(isVisible: false)
    }
    
    func didUpdateData() {
        measurementTableView.reloadData()
        loadingView.toggle(isVisible: false)
    }
}
