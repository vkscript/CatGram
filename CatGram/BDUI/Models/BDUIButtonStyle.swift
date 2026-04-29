//
//  BDUIButtonStyle.swift
//  CatGram
//

import Foundation

enum BDUIButtonStyle: String, Codable {
    case primary
    case secondary
    case destructive
    case text
    
    var dsStyle: DSButton.Style {
        switch self {
        case .primary: return .primary
        case .secondary: return .secondary
        case .destructive: return .destructive
        case .text: return .text
        }
    }
}
