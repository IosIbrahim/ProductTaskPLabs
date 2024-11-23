//
//  RGTextField.swift
//
//  Created by Jamal alayq on 4/7/20.
//  Copyright © 2020 eltawasol. All rights reserved.
//

import UIKit
import Viewity

class RGTextField: UITextField {
    @IBInspectable var hint: String? { didSet { setNeedsDisplay() } }
    @IBInspectable var hintColor: UIColor = UIColor.white { didSet { setNeedsDisplay() } }
    @IBInspectable var placeholderColor: UIColor = UIColor.white { didSet { setNeedsDisplay() } }
    @IBInspectable var withDivider: Bool = false { didSet { setNeedsDisplay() } }
    @IBInspectable
    // MARK: - UI Components
    private lazy var lblHint: UILabel = .init()
    private let divider: UIView = {
        let view: UIView = .init()
        view.background(Colors.appBackground() ?? .white, animated: false)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func draw(_ rect: CGRect) {
        setStyle()
    }

    private func setup() {
        add(lblHint)
        keyboardAppearance = .dark
        lblHint.align(a: .top, to: topAnchor, -16)
            .align(a: .leading, to: leadingAnchor)
        clipsToBounds = false
    }

    private func setStyle() {
        if hint != nil {
            lblHint.foreground(hintColor)
                .text(hint ?? .empty)
                .alignment(.natural)
        } else {
            lblHint.removeFromSuperview()
        }

        border(style: .none)
            .attributedPlaceholder = NSAttributedString(
                string: placeholder ?? .empty, attributes: [
                    NSAttributedString.Key.foregroundColor: placeholderColor
                ]
        )
        self.textAlignment = Language.isArabic() ? .right : .left
        self.setSemiBoldFont(.s15)
        if withDivider {
            add(divider)
            divider.setDimensions(.height, 2)
                .align(a: .bottom, to: bottomAnchor)
                .align(a: .leading, to: leadingAnchor)
                .align(a: .trailing, to: trailingAnchor)
        }

    }

}
extension UIView {
    @objc enum Style: Int {
        case normal = 0
        case roundedRight
        case roundedLeft
        case `default`
    }
}
