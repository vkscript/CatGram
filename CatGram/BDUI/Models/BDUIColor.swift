//
//  BDUIColor.swift
//  CatGram
//

import UIKit

enum BDUIColor: String, Codable {
    case background
    case secondaryBackground
    case primary
    case secondary
    case textPrimary
    case textSecondary
    case textTertiary
    case error
    case success
    case separator
    case border
    case clear
    case white
    case black
    
    var uiColor: UIColor {
        switch self {
        case .background: return DS.Colors.background
        case .secondaryBackground: return DS.Colors.secondaryBackground
        case .primary: return DS.Colors.primary
        case .secondary: return DS.Colors.secondary
        case .textPrimary: return DS.Colors.textPrimary
        case .textSecondary: return DS.Colors.textSecondary
        case .textTertiary: return DS.Colors.textTertiary
        case .error: return DS.Colors.error
        case .success: return DS.Colors.success
        case .separator: return DS.Colors.separator
        case .border: return DS.Colors.border
        case .clear: return .clear
        case .white: return .white
        case .black: return .black
        }
    }
}
