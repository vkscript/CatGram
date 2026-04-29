//
//  BDUIAlignment.swift
//  CatGram
//

import UIKit

enum BDUIAlignment: String, Codable {
    case fill
    case leading
    case center
    case trailing
    case top
    case bottom
    
    var stackAlignment: UIStackView.Alignment {
        switch self {
        case .fill: return .fill
        case .leading: return .leading
        case .center: return .center
        case .trailing: return .trailing
        case .top: return .top
        case .bottom: return .bottom
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .leading: return .left
        case .center: return .center
        case .trailing: return .right
        default: return .natural
        }
    }
}
