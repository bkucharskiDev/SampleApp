//
//  UITableView+Dequeue.swift
//  SampleApp
//
//  Created by Bartosz Kucharski on 07.05.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath) -> T where T: Identifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell with identifier: \(T.identifier)")
        }
        return cell
    }
}
