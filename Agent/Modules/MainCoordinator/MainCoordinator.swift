//
//  MainCoordinator.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import UIKit

final class MainCoordinator: NSObject {
    internal private(set) var window: UIWindow?
    private var navigator: Navigator?
    
    internal static var `public`: MainCoordinator? {
        if #available(iOS 13.0, *) {
            return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.mainCoordinator
        } else {
            return (UIApplication.shared.delegate as? AppDelegate)?.mainCoordinator
        }
    }
    
    internal init(_ window: UIWindow?) {
        self.window = window
    }
    
    internal enum Routes {
        case start
        case begin
        case details(ProductModel)
        case pop
    }
    
    internal func move(to screen: Routes) {
        switch screen {
        case .start: start()
        case .begin: begin()
        case .details(let item):openDetails(item)
        case .pop: popUp()
        }
    }
    
    func fetchRoot() -> UIViewController {
        return window?.rootViewController ?? .init()
    }
    
    private func start() {
        makeSplashScreenIsDefault()
        window?.makeKeyAndVisible()
    }
    
    private func begin() {
        clearNavigator()
        openProducts()
    }
    private func restart() {
        start()
        guard let view = window?.rootViewController?.view else { return }
        DispatchQueue.main
            .asyncAfter(deadline: .now() + .milliseconds(20)) {
                UIView.transition(
                    with: view,
                    duration: 0.3,
                    options: [.transitionFlipFromLeft],
                    animations: .none,
                    completion: .none
                )
            }
    }
    
    
    private func makeSplashScreenIsDefault() {
        clearNavigator()
        navigator = Navigator(rootViewController: SplashController())
        navigator?.navigationBar.isHidden = true
        ViewsDirection.setLanguageDirection()
        window?.rootViewController = navigator
    }
    
    
    private func openProducts() {
        let vc = ProductsController()
        navigator = Navigator(rootViewController: vc)
        navigator?.setToolbarHidden(true, animated: true)
        ViewsDirection.setLanguageDirection()
        window?.rootViewController = navigator
    }
    
    private func openDetails(_ item:ProductModel) {
        let vc = DetailsController()
        vc.product = item
        navigator?.pushViewController(vc, animated: true)
    }
    
    private func clearNavigator() {
        navigator?.viewControllers.removeAll()
        navigator?.removeFromParent()
        navigator = nil
    }
    
    private func popUp() {
        navigator?.popViewController(animated: true)
    }

}

