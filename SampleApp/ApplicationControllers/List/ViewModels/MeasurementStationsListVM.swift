//
//  MeasurementStationsListVM.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 04.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
 
final class MeasurementStationsListVM: ListViewModelProtocol {
    
    typealias Dependencies = HasAirQualityService
    
    weak var delegate: ListViewModelDelegate?
    
    private let dependencies: Dependencies
    
    private var measurementStations: [[MeasurementStation]] = [] {
        didSet {
            delegate?.didUpdateData()
        }
    }
    
    var handleSelect: ((_ measurementStation: MeasurementStation) -> Void)?
    
    var numberOfSections: Int {
        return measurementStations.count
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
        fetchStations()
    }
    
    func numberOfRows(in section: Int) -> Int {
        return measurementStations[section].count
    }
    
    func titleForRow(at indexPath: IndexPath) -> String {
        return measurementStations[indexPath.section][indexPath.row].stationName
    }
    
    func titleForSection(_ section: Int) -> String {
        return measurementStations[section].first?.city.name ?? ""
    }
    
    func selectRow(at indexPath: IndexPath) {
        handleSelect?(measurementStations[indexPath.section][indexPath.row])
    }
    
    private func fetchStations() {
        let allStations = dependencies.airQualityService.getAllStations()
        var stationsDictionary: [String: [MeasurementStation]] = [:]
        allStations.forEach {
            var stations = stationsDictionary[$0.city.name] ?? []
            stations.append($0)
            stationsDictionary[$0.city.name] = stations
        }
        
        let sortedStations = stationsDictionary.sorted(by: { $0.key < $1.key  })
        
        measurementStations = sortedStations.map { $0.value }
    }
}
