//
//  ComboBox.swift
//  LutfiDriver
//
//  Created by Jamal Alayq on 3/22/19.
//  Copyright © 2019 Jamal Alayq. All rights reserved.
//

import UIKit

typealias ComboBoxHandler = (ComboBox.Item) -> Void

final class ComboBox: RGTextField, UIPickerViewDelegate, UIPickerViewDataSource, Localizable, Toolbarable {
    
    var data = Array<Item>() {
        didSet {
            DispatchQueue.main.async {
                if !self.data.isEmpty {
                    self.picker.reloadAllComponents()
                }
            }
        }
    }
    
    @IBInspectable var imgTintColor: UIColor = UIColor.black {
        didSet {
            self.indicator.image = self.indicator.image?.withRenderingMode(.alwaysTemplate)
            self.indicator.tintColor = imgTintColor
        }
    }
    
    var onDone: ComboBoxHandler?
    var selectItem: ComboBoxHandler?
    var onEmpty: HandlerCombo?
    internal private(set) var selectedIndex: UInt = .zero
    @IBInspectable
    var image: UIImage? = UIImage() {
        didSet {
        indicator.image = image
        }
    }
    
    private lazy var picker: UIPickerView = {
        let picker: UIPickerView = .init()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
//    private var leftImage: RoundedImageView = {
//        let img: RoundedImageView = .init(frame: .zero)
//        img.contentMode = .center
//        img.tintColor = .clear
//        img.backgroundColor = .clear
//        return img
//    }()
    
    private let btnSelect: UIButton = {
        let btn: UIButton = .init()
        btn.backgroundColor = .clear
        btn.userInteraction(enabled: true)
        btn.setTitle(nil, for: .normal)
        btn.tintColor = .clear
        return btn
    }()
    
    private let leftPanel: UIView = {
        let view = UIView()
        view.background(.clear)
        return view
    }()
    
    private let indicator: UIImageView = {
        let indicator: UIImageView = .init(image: Images.icArrowDown())
        indicator.clipsToBounds = true
        indicator.contentMode = .center
     //   indicator.tintColor = Images.icTo()?.fetchTintColor()
        indicator.tintColor = .black
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        add(btnSelect)
        btnSelect.fill()
        btnSelect.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    private func setLeftPanel() {
   //     leftPanel.add(leftImage)
     //   leftImage.fill()
        add(leftPanel)
        leftPanel.align(a: .top, to: topAnchor, 8)
            .align(a: .bottom, to: bottomAnchor, 8)
            .align(a: .leading, to: leadingAnchor, 8)
            .setDimensions(.width, bounds.size.height - 16)
        leftPanel.corners((bounds.size.height - 16) / 2)
    }
    
    private func setRightPanel() {
        add(indicator)
        indicator.align(a: .top, to: topAnchor)
            .align(a: .bottom, to: bottomAnchor)
            .align(a: .trailing, to: trailingAnchor, 8)
            .setDimensions(.width, bounds.size.height)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        textAlignment = Language.isArabic() ? .right : .left
        tintColor = .clear
        delegate = self
        // rightViewMode = .always
        // rightView = indicator
        setRightPanel()
        setLeftPanel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bringSubviewToFront(btnSelect)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = data[row]
        selectedIndex = UInt(row)
        fillData(for: item)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.selectItem?(item)
        }
    }
    
    private func fillData(for item: Item) {
        text = item.title
//        leftImage.image = item.image
//        if let color = item.color {
//            leftImage.image = .init()
//            leftImage.border(width: 0.5, color: .lightGray)
//            leftImage.backgroundColor = UIColor(hex: color)
//        } else {
//            leftImage.backgroundColor = .clear
//            leftImage.border(width: .zero, color: .clear)
//            if let url = item.imageUrl {
//                leftImage.loadImageWithoutCash(url)
//            } else {
//                leftImage.image = item.image
//                leftImage.image = nil
//            }
//        }
        leftPanel.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        let container: UIView = .init(
            frame: .init(
                origin: .zero,
                size: .init(
                    width: UIScreen.main.bounds.size.width,
                    height: 50.0
                )
            )
        )
        let item = data[row]
        let label: UILabel = .init()
        label.setBoldFont(.s20)
        label.textColor = .white
        label.text = item.title
        label.textAlignment = .center
   //     let imageView: RoundedImageView = .init(frame: .zero)
//        if let color = item.color {
//            imageView.image = nil
//            imageView.backgroundColor = UIColor(hex: color)
//        } else {
//            leftImage.backgroundColor = .clear
//            if item.image == .none {
//                imageView.loadImageWithoutCash(item.imageUrl ?? "")
//            } else {
//                imageView.image = item.image
//            }
//        }
//        imageView.contentMode = .scaleAspectFit
    //    container.add(imageView, label)
        container.add(label)
   //     let margin: CGFloat = 10
//        imageView.align(a: .leading, to: container.leadingAnchor, margin)
//            .align(a: .top, to: container.topAnchor, margin)
//            .align(a: .bottom, to: container.bottomAnchor, margin)
//            .setDimensions(.width, container.bounds.size.height - (margin * 2))
        label.putInCenter()
        container.backgroundColor = .clear
        return container
    }
    
    @objc private func doneOnTap() {
        self.resignFirstResponder()
    }
    
    @objc private func didTap() {
        if !data.isEmpty {
            inputAccessoryView = createToolBar(#selector(doneOnTap))
            inputView = picker
            selectedIndex = .zero
            fillData(for: data[.zero])
            becomeFirstResponder()
        } else {
            if onEmpty == nil {
//                attributedPlaceholder = NSAttributedString(
//                    string: localize(Localizations.noData),
//                    attributes: [.foregroundColor: UIColor.red]
//                )
            } else {
                onEmpty?()
            }
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .zero)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .zero)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .zero)
    }
    
    final class Item {
        
        let id: UInt64
        let title: String
        var image: UIImage?
        var color: String?
        var imageUrl: String?
        
        required init(id: UInt64, title: String, image: UIImage?, color: String?, imageUrl: String?) {
            self.id = id
            self.title = title
            self.image = image
            self.color = color
            self.imageUrl = imageUrl
        }
        
    }
}

// MARK:- TEXT FIELDS DELEGATE FUNCTIONS

extension ComboBox: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard !data.isEmpty else { return }
        onDone?(data[Int(selectedIndex)])
    }
    
}

final class RoundedImageView: UIImageView {
    
    internal var onTap: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickAction)))
    }
    
    @objc private func clickAction() {
        onTap?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = midHeight
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        layer.cornerRadius = midHeight
        layer.masksToBounds = true
        clipsToBounds = true
      //  border(width: 1, color: Colors.appGreen() ?? .green)
    }
}
