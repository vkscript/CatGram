//
//  BDUIDistribution.swift
//  CatGram
//

import UIKit

enum BDUIDistribution: String, Codable {
    case fill
    case fillEqually
    case fillProportionally
    case equalSpacing
    case equalCentering
    
    var stackDistribution: UIStackView.Distribution {
        switch self {
        case .fill: return .fill
        case .fillEqually: return .fillEqually
        case .fillProportionally: return .fillProportionally
        case .equalSpacing: return .equalSpacing
        case .equalCentering: return .equalCentering
        }
    }
}
