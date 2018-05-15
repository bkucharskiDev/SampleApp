//
//  MeasurementStationVM.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 07.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

protocol MeasurementStationVMDelegate: class {
    
    func didStartUpdatingData()
    func didFailUpdatingData()
    func didUpdateData()
}

final class MeasurementStationVM {
    
    weak var delegate: MeasurementStationVMDelegate?
    
    private let airQualityService: AirQualityServiceProtocol
    private let measurementStation: MeasurementStation
    private var cellViewModels: [MeasurementCellVM] = []
    private var sensors: [Sensor] = []
    private var sensorData: [SensorData] = []
    
    var numberOfRows: Int {
        return cellViewModels.count
    }
    
    var city: String {
        return measurementStation.city.name
    }
    
    var stationName: String {
        return measurementStation.stationName
    }
    
    var handleDownloadFailure: ((Error?) -> Void)?
    
    init(airQualityService: AirQualityServiceProtocol, measurementStation: MeasurementStation) {
        self.airQualityService = airQualityService
        self.measurementStation = measurementStation
    }
    
    func cellVM(at indexPath: IndexPath) -> MeasurementCellVM {
        return cellViewModels[indexPath.row]
    }
    
    func getData() {
        airQualityService.getStationSensors(stationId: measurementStation.id) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            self.delegate?.didStartUpdatingData()
            
            switch result {
            case .success(let sensors):
                self.sensors = sensors
                self.getSensorData()
            case .failure(let error):
                self.handleDownloadFailure?(error)
                self.delegate?.didFailUpdatingData()
            }
        }
    }
    
    private func getSensorData() {
        
        if sensors.isEmpty {
            delegate?.didUpdateData()
        }
        
        for (index, sensor) in sensors.enumerated() {
            airQualityService.getSensorData(sensorId: sensor.id, completion: { [weak self] (result) in
                guard let `self` = self else { return }
                
                switch result {
                case .success(let sensorData):
                    
                    self.sensorData.append(sensorData)
                    
                    if index == self.sensors.endIndex - 1 {
                        self.prepareCellVms()
                    }
                case .failure(let error):
                    self.handleDownloadFailure?(error)
                    self.delegate?.didFailUpdatingData()
                    break
                }
            })
        }
    }
    
    private func prepareCellVms() {
        
        let filteredSensorData = getSensorDataWithoutEmptyValues()
        
        if filteredSensorData.isEmpty {
            delegate?.didUpdateData()
        }
        
        for (index, data) in filteredSensorData.enumerated() {
            
            let cellVM: MeasurementCellVM
            var date: String = ""
            var value: String = ""
            
            if let nonNilSensorValue = getFirstNonNilValueFrom(sensorData: data) {
                date = nonNilSensorValue.date
                value = "\(nonNilSensorValue.value!)"
            } else {
                if let firstValue = data.values.first {
                    date = firstValue.date
                    value = "-"
                }
            }
            
            cellVM = MeasurementCellVM(key: data.key, date: date, value: value)
            cellViewModels.append(cellVM)
            if index == filteredSensorData.endIndex - 1 {
                delegate?.didUpdateData()
            }
        }
    }
    
    private func getSensorDataWithoutEmptyValues() -> [SensorData] {
        return sensorData.filter({
            !$0.values.isEmpty
        })
    }
    
    private func getFirstNonNilValueFrom(sensorData: SensorData) -> SensorData.Value? {
        return sensorData.values.first(where: {
            $0.value != nil
        })
    }
}
