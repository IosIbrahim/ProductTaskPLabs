//
//  Navigatot.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import UIKit
import Hero
final class Navigator: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = false
//        var attrs = [
//            NSAttributedString.Key.foregroundColor: Colors.appGreen() ?? .green,
//            NSAttributedString.Key.font: FontStyle.shared.setBoldFont(.s20)
//        ]
//        let type = MainCoordinator.public?.category?.type
//        if type == .maintainace || type == .transportation || type == .salsabil {
//            attrs = [
//                NSAttributedString.Key.foregroundColor: UIColor(hex: "#063992") ?? .blue,
//                NSAttributedString.Key.font: FontStyle.shared.setBoldFont(.s20)
//            ]
//        }
//        UINavigationBar.appearance().titleTextAttributes = attrs as [NSAttributedString.Key : Any]
//        navigationBar.backgroundColor = .white
//        if type == .maintainace || type == .transportation || type == .salsabil  {
//            navigationBar.tintColor =  UIColor(hex: "#063992") ?? .blue
//            if type == .transportation || type == .salsabil {
//                navigationBar.isHidden = false
//            }
//        }else {
//            navigationBar.tintColor =  Colors.appGreen() ?? .green
//        }
        self.view.backgroundColor = .white
        navigationBar.isHidden = true
        self.hero.isEnabled = true
   //     self.hero.navigationAnimationType = .push(direction: .down)

    }
}
