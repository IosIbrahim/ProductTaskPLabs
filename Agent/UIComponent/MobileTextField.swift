//
//  MobileTextField.swift
//  LutfiDriver
//
//  Created by Jamal Alayq on 3/19/19.
//  Copyright © 2019 Jamal Alayq. All rights reserved.
//

import UIKit
import Simplebest
import Locality
import Defaulty

typealias CountryHandler = () -> Void

final class MobileTextField: UITextField {
    
    @IBInspectable
    var code: String = "" { didSet { lblCode.text = code } }
    @IBInspectable
    var flag: UIImage? = UIImage() { didSet { imgFlag.image = flag } }
    var isValid: Bool = true { didSet { rightPanel.isHidden = !isValid } }

    private let pumb = CGFloat(0.28)
    var mobileLength: Int? = 10
    
    // MARK:- INTERNAL VARIABLES
    
    internal var chooseCountryHandler: CountryHandler?
    
    // MARK:- INTERNAL COMPUTED PROPERITES
    
    internal var phone: String {
        return clear.phoneWithCode
    }
    
    internal var phoneWithoutCode: String {
        return clear.phoneWithoutCode
    }
    
    private var clear: (phoneWithCode: String, phoneWithoutCode: String) {
        let codeWithoutPlus = (lblCode.text ?? "").replacingOccurrences(of: "+", with: "")
        var mobile = (text ?? "").replacingOccurrences(of: "+", with: "")
        if mobile.hasPrefix(codeWithoutPlus) {
            let range = codeWithoutPlus.startIndex..<codeWithoutPlus.endIndex
            mobile = mobile.replacingOccurrences(of: codeWithoutPlus,
                                                 with: "",
                                                 options: .literal,
                                                 range: range)
        }
        let phoneWithoutCode = (mobile)
            .replacingOccurrences(of: " ", with: "")
            .trimmingCharacters(in: .whitespaces)
        let phoneWithCode = (codeWithoutPlus + mobile)
            .replacingOccurrences(of: " ", with: "")
            .trimmingCharacters(in: .whitespaces)
        return (phoneWithCode, phoneWithoutCode)
    }
    
    // MARK:- PRIAVTE COMPUTED PROPERTIES
    
    private var codeViewWidth: CGFloat {
        return bounds.size.width * pumb
    }
    
    // MARK:- UI COMPONENTS
    
    private lazy var lblCode: UILabel = {
        let lbl = UILabel()
        lbl.font = font
        lbl.textColor = Colors.appBlack()
        lbl.textAlignment = .center
        lbl.setSemiBoldFont(.s18)
        lbl.text = "20"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let imgFlag: UIImageView = {
        let iv = UIImageView.init()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.layer.masksToBounds = true
        iv.image = .init()
        return iv
    }()
    
//    private let imgDownArraow: UIImageView = {
//        let iv = UIImageView.init()
//        iv.contentMode = .center
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.isUserInteractionEnabled = true
//        iv.layer.masksToBounds = true
//        iv.tintColor = .white
//        iv.image = UIImage(named: "")
//        return iv
//    }()
    
    private let divider: UIView = {
        let view: UIView = .init()
        view.backgroundColor = Colors.appBackground()
        return view
    }()
    
    private let stkLeftView: UIStackView = {
        let stk = UIStackView()
        stk.axis = .horizontal
        stk.spacing = 6
        stk.alignment = UIStackView.Alignment.center
        stk.distribution = UIStackView.Distribution.fill
        stk.semanticContentAttribute = .playback
        return stk
    }()
    
    private let rightPanel: UIView = {
        let view: UIView = .init()
        let img: UIImageView = .init(image: UIImage(named: "ic-success"))
        img.contentMode = .scaleAspectFit
        view.add(img)
        view.isHidden = true
        img.fill(.init(top: 4, left: 4, bottom: 4, right: 8))
        return view
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addTarget(self, action: #selector(whileTextChanging(_:)), for: .editingChanged)
        addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        setUp()
        setLeftView()
        setRightPanel()
    }
    
    private func setUp() {
        textAlignment = .left
        semanticContentAttribute = .playback
        keyboardType = .asciiCapableNumberPad
        textContentType = .telephoneNumber
        borderStyle = .none
        placeholder = Localizations.mobile.key.localize()
        setBoldFont(.s18)
    }
    
    private func setRightPanel() {
        add(rightPanel)
        rightPanel.align(a: .top, to: topAnchor)
            .align(a: .bottom, to: bottomAnchor)
            .align(a: .trailing, to: trailingAnchor)
            .setDimensions(.width, bounds.size.width * 0.13)
    }
    
    private func setLeftView() {
        leftViewMode = .always
        imgFlag.setDimensions(.init(width: 20, height: 20))
        stkLeftView.addArrangedSubview(imgFlag)
        stkLeftView.addArrangedSubview(lblCode)
     //   stkLeftView.addArrangedSubview(imgDownArraow)
        let leftPanel = UIView.init(frame: .init(x: 0, y: 0, width: codeViewWidth, height: bounds.size.height))
        leftPanel.isUserInteractionEnabled = true
        leftPanel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(chooseCodeOnTap)))
        leftPanel.add(stkLeftView, divider)
        divider.setDimensions(.init(width: 1, height: bounds.size.height * 0.50))
            .align(a: .right, to: leftPanel.rightAnchor)
            .putInCenter(at: .vertical)
        stkLeftView.align(a: .top, to: leftPanel.topAnchor)
            .align(a: .bottom, to: leftPanel.bottomAnchor)
            .align(a: .left, to: leftPanel.leftAnchor, 12)
            .align(a: .right, to: divider.leftAnchor, 4)
        imgFlag.layer.cornerRadius = 10
        leftView = leftPanel
    }
    
    // MARK:- CUSTOM RECT
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: 0, left: codeViewWidth + 8, bottom: 0, right: 8))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: 0, left: codeViewWidth + 8, bottom: 0, right: 8))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: 0, left: codeViewWidth + 8, bottom: 0, right: 8))
    }
    
    @objc private func chooseCodeOnTap() {
        chooseCountryHandler?()
    }
    
    @objc private func didBeginEditing() {
        print(#function)
        // working on less than 13
        guard let length = mobileLength else { return }
        rightPanel.hidden(!(phoneWithoutCode.count == length))
    }
    
    @objc private func whileTextChanging(_ sender: MobileTextField) {
        guard let length = mobileLength else { return }
        // TODO: validate `phoneWithoutCode` with length validation in country status
        if case phoneWithoutCode.count = length {
            // show true check mark in right of control
            text = phoneWithoutCode.withoutZero
            text = phoneWithoutCode

            rightPanel.hidden(false)
          //  isValid = true
        } else {
            let first = phoneWithoutCode.withoutZero.prefix(length).toString()
       //     let first = phoneWithoutCode.prefix(length).toString()
            text = first
            rightPanel.hidden(phoneWithoutCode.count != length)
        }
        isValid = !rightPanel.isHidden
        self.isValid = phoneWithoutCode.count == length
    }
}
