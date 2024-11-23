//
//  SplashController.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import UIKit
import RevealingSplashView

class SplashController: ViewController {

    private var second = 1.3
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "ic-task") ?? .init(),iconInitialSize: CGSize(width: 236, height: 255), backgroundColor: .clear)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = .twitter
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goHome()
    }
    
    private func goHome(){
        DispatchQueue.main.asyncAfter(deadline: .now() + second) {
            self.revealingSplashView.startAnimation {
                MainCoordinator.public?.move(to: .begin)
            }
        }
    }
    
    override func setLocalizations() {
        print("")
    }

}
