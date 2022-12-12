//
//  UITableView+Extension.swift
//  ZZExtension
//
//  Created by Ethan on 2022/5/13.
//  Copyright © 2022 ZZExtension. All rights reserved.
//

import UIKit

// MARK: - Properties

public extension ZZ where Base: UITableView {

}

// MARK: - Methods

public extension ZZ where Base: UITableView {

    /// Register UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        base.register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    /// Dequeue reusable UITableViewCell using class name for indexPath
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = base.dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

}
