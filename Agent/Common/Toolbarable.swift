//
//  Toolbarable.swift
//  ShipmentCourier
//
//  Created by Jamal alayq on 6/30/20.
//  Copyright © 2020 eltawasol. All rights reserved.
//

import Foundation
import UIKit

protocol Toolbarable { }
extension Toolbarable {
    func createToolBar(_ selector: Selector) -> UIToolbar {
        let toolBar: UIToolbar = .init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 35))
        toolBar.isTranslucent = true
        toolBar.barStyle = .default
        toolBar.tintColor = Colors.appBlue()
        toolBar.barTintColor = .backgroundColor
        toolBar.items = [
            .init(barButtonSystemItem: .flexibleSpace, target: .none, action: .none),
            .init(title: Localizations.done.key.localize(), style: .plain, target: self, action: selector)
        ]
        return toolBar
    }
}
