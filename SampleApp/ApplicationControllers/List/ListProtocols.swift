//
//  ListProtocols.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 04.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import Foundation

protocol ListViewModelProtocol {
    
    weak var delegate: ListViewModelDelegate? { get set }
    
    var numberOfSections: Int { get }
    
    func numberOfRows(in section: Int) -> Int
    func titleForRow(at indexPath: IndexPath) -> String
    func titleForSection(_ section: Int) -> String
    func selectRow(at indexPath: IndexPath)
}

protocol ListViewModelDelegate: class {
    
    func didUpdateData()
}
