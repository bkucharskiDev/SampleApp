//
//  MeasurementCell.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 07.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

class MeasurementCell: UITableViewCell, Identifiable {

    @IBOutlet private weak var keyLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setupWith(_ viewModel: MeasurementCellVMProtocol) {
        keyLabel.text = viewModel.key
        dateLabel.text = viewModel.date
        valueLabel.text = viewModel.value
    }
    
    private func setup() {
        selectionStyle = .none
    }
}
