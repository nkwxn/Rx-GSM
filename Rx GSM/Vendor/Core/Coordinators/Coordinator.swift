//
//  Coordinator.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Foundation

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
