//
//  Confirmable.swift
//  ShipmentCourier
//
//  Created by Jamal alayq on 7/8/20.
//  Copyright © 2020 eltawasol. All rights reserved.
//

import Foundation
import UIKit

protocol Confirmable: Localizable { }
extension Confirmable where Self: UIViewController {
    func confirm(_ message: String?, title: String, _ confirmation: @escaping() -> Void) {
        runOnMainThread {
            let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alertController.view.tint(.enabledButtonColor)
            alertController.addAction(.init(title: title, style: .default, handler: { _ in
                confirmation()
            }))
            alertController.addAction(.init(title: self.localize(Localizations.cancel), style: .cancel))
            self.present(alertController, animated: true)
        }
    }
    
    func confirm(_ message: String?) {
        runOnMainThread {
            let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alertController.view.tint(.enabledButtonColor)
            alertController.addAction(.init(title: self.localize(Localizations.ok), style: .default))
            self.present(alertController, animated: true)
        }
    }
}

func runOnMainThread(_ work: @escaping() -> Void) {
    if Thread.isMainThread {
        work()
    } else {
        DispatchQueue.main.async {
            work()
        }
    }
}
