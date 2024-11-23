//
//  VewDirections.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import UIKit
import ILocalizer
import FSCalendar

final class ViewsDirection: NSObject {
    private override init() { }

    internal static func setLanguageDirection() {
        getLanguageDirection {
            UIView.appearance().semanticContentAttribute = $0
            UITableViewCell.appearance().semanticContentAttribute = $0
            UITextField.appearance().semanticContentAttribute = $0
            UITextView.appearance().semanticContentAttribute = $0
            UICollectionView.appearance().semanticContentAttribute = $0
            FSCalendar.appearance().semanticContentAttribute = $0
        }
    }

    private static func getLanguageDirection(_ handler: @escaping (UISemanticContentAttribute) -> Void) {
        let isArabic = ILocalizer.current == Language.arabic.rawValue
        let direction: UISemanticContentAttribute = isArabic ? .forceRightToLeft : .forceLeftToRight
        handler(direction)
    }
}
