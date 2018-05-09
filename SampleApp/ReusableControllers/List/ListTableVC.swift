//
//  ListTableVC.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 04.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

final class ListTableVC: UITableViewController {
    
    private let viewModel: ListViewModelProtocol
    
    private let cellId = "cellId"
    
    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// MARK: - UITableViewDataSource
extension ListTableVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: cellId)
        cellHeader?.backgroundColor = .gray
        cellHeader?.textLabel?.text = viewModel.titleForSection(section)
        
        return cellHeader
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = viewModel.titleForRow(at: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRow(at: indexPath)
    }
}
