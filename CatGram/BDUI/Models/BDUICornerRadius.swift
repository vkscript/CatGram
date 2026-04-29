//
//  BDUICornerRadius.swift
//  CatGram
//

import UIKit

enum BDUICornerRadius: String, Codable {
    case none
    case small
    case medium
    case large
    case custom
    
    var value: CGFloat {
        switch self {
        case .none: return 0
        case .small: return DS.Spacing.cornerRadiusSmall
        case .medium: return DS.Spacing.cornerRadiusMedium
        case .large: return DS.Spacing.cornerRadiusLarge
        case .custom: return 0
        }
    }
}
