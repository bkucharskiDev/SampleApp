//
//  MeasurementStationVM.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 07.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

protocol MeasurementStationVMDelegate: class {
    
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
            
            switch result {
            case .success(let sensors):
                self.sensors = sensors
                self.getSensorData()
            case .failure(let error):
               self.handleDownloadFailure?(error)
            }
        }
    }
    
    private func getSensorData() {
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
                    break
                }
            })
        }
    }
    
    private func prepareCellVms() {
        for (index, sensor) in sensorData.enumerated() {
            guard !sensor.values.isEmpty else {
                if index == sensorData.endIndex - 1 {
                    delegate?.didUpdateData()
                }
                continue
            }
            
            let cellVM: MeasurementCellVM
            
            if let sensorData = sensor.values.first(where: {
                $0.value != nil
            }) {
                cellVM = MeasurementCellVM(key: sensor.key,
                                               date: sensorData.date,
                                               value: "\(sensorData.value!)")
            }
            else {
                let firstValue = sensor.values.first!
                cellVM = MeasurementCellVM(key: sensor.key,
                                           date: firstValue.date,
                                           value: "-")
            }
            
            cellViewModels.append(cellVM)
            if index == sensorData.endIndex - 1 {
                delegate?.didUpdateData()
            }
        }
    }
}
