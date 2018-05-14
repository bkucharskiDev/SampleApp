//
//  MeasurementStationsListVM.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 04.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation
 
final class MeasurementStationsListVM: ListViewModelProtocol {
    
    weak var delegate: ListViewModelDelegate?
    
    private let airQualityService: AirQualityServiceProtocol
    
    private var measurementStations: [[MeasurementStation]] = [] {
        didSet {
            delegate?.didUpdateData()
        }
    }
    
    var handleSelect: ((_ measurementStation: MeasurementStation) -> Void)?
    
    var numberOfSections: Int {
        return measurementStations.count
    }
    
    init(airQualityService: AirQualityServiceProtocol) {
        self.airQualityService = airQualityService
        
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
        let allStations = airQualityService.getAllStations()
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
