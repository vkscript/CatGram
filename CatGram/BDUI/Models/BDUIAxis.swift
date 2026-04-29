//
//  BDUIAxis.swift
//  CatGram
//

import UIKit

enum BDUIAxis: String, Codable {
    case horizontal
    case vertical
    
    var nsLayoutAxis: NSLayoutConstraint.Axis {
        switch self {
        case .horizontal: return .horizontal
        case .vertical: return .vertical
        }
    }
}
