//
//  Language.swift
//  Agent
//
//  Created by ibrahim on 08/02/2023.
//

import Foundation
import ILocalizer

enum Language: String {
    case arabic = "ar"
    case english = "en"

    static func isArabic() -> Bool { ILocalizer.current == Language.arabic.rawValue }
    static func isEnglish() -> Bool { ILocalizer.current == Language.english.rawValue }
}
