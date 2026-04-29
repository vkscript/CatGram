//
//  BDUIContentMode.swift
//  CatGram
//

import UIKit

enum BDUIContentMode: String, Codable {
    case scaleToFill
    case scaleAspectFit
    case scaleAspectFill
    case center
    
    var uiContentMode: UIView.ContentMode {
        switch self {
        case .scaleToFill: return .scaleToFill
        case .scaleAspectFit: return .scaleAspectFit
        case .scaleAspectFill: return .scaleAspectFill
        case .center: return .center
        }
    }
}
