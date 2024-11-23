//
//  Localizable.swift
//  Agent
//
//  Created by ibrahim on 09/02/2023.
//

import Foundation
import UIKit
import Rswift

typealias localize = R.string.localizable
typealias Localizations = R.string.localizable
typealias Images = R.image
typealias Colors = R.color

protocol Localizabletions where Self: UIViewController {
    func setLocalizations()
}

protocol Localizable { }
extension Localizable {
    func localize(_ key: StringResource) -> String { key.key.localize() }
}
