//
//  ViewController.swift
//  Agent
//
//  Created by Ibrahim Sabry on 13/02/2023.
//

import Foundation
import UIKit
import Toastlity
import Hero
import NVActivityIndicatorView


class ViewController: UIViewController, Localizabletions,Confirmable {
    
    lazy var toastBar: ToastBar = .init(settings: .agent, in: parent?.view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // view.background(.white, animated: false)
        setLocalizations()
        self.isHeroEnabled = true
    //    self.hero.modalAnimationType = .push(direction: .down)
    //    self.hero.tabBarAnimationType = .push(direction: .down)

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    class var instance: Self { UIViewController() as! Self }
    
    func setLocalizations() { }
    
    @objc func doneOnTap() {
        self.view.endEditing(true)
    }
    
    @objc func dismissOnTap() {
        self.dismiss(animated: true)
    }
    
    func closeKeyBoard() {
        self.view.userInteraction(enabled: true)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(doneOnTap)))
    }
    
    func tapToDismiss() {
        self.view.userInteraction(enabled: true)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(dismissOnTap)))
    }
    
    func showToast(_ error:String) {
        toastBar.show(with: error)
    }
    
    
    
}

extension UIViewController {
    func push(_ vc:UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popUp() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIViewController: NVActivityIndicatorViewable {
    
    func showIndicator(_ show: Bool = true) {
        if show {
            let size = CGSize(width: getRatio(70), height: getRatio(70))
            startAnimating (size , type: .ballBeat, color: .white, padding: 10)
        } else {
            stopAnimating()
        }
    }
    
    func getRatio(_ number: CGFloat) -> CGFloat {
        let ratio = CGFloat(Int(number * UIScreen.main.bounds.width / 360))
        print(UIScreen.main.bounds.width)
        return ratio > 0 ? ratio : CGFloat(number * UIScreen.main.bounds.width / 360)
    }
}

extension ToastSettings {
    static var agent: ToastSettings {
        var settings = ToastSettings.default
        settings.mode = .top
        settings.backgroundColor = .enabledButtonColor
        settings.textColor = .white
        settings.font = FontStyle.shared.setBoldFont(.s18)
        settings.autoHide = true
        return settings
    }
}

extension UIViewController {
    func openSettings() {
        openLink(UIApplication.openSettingsURLString)
    }

    func makeCall(to number: String) {
        openLink("tel://\(number)")
    }

    func openLink(_ link: String) {
        let app = UIApplication.shared
        guard let url = URL(string: link) else {
            return print(#function, "error in settings url.")
        }
        app.open(url, options: .init())
    }
}


protocol Sharable { }
extension Sharable where Self: UIViewController {
    
    func share(_ content: Array<Any>) {
        let shareActivity = UIActivityViewController(activityItems: content, applicationActivities: nil)
        shareActivity.excludedActivityTypes = [
            .copyToPasteboard,
            .mail,
            .message,
            .postToFacebook,
            .postToTwitter,
            .print
        ]
        self.present(shareActivity, animated: true)
    }
    
}
