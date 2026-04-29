//
//  BDUITypography.swift
//  CatGram
//

import UIKit

enum BDUITypography: String, Codable {
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case body
    case callout
    case subheadline
    case footnote
    case caption1
    case caption2
    
    var font: UIFont {
        switch self {
        case .largeTitle: return DS.Typography.largeTitle()
        case .title1: return DS.Typography.title1()
        case .title2: return DS.Typography.title2()
        case .title3: return DS.Typography.title3()
        case .headline: return DS.Typography.headline()
        case .body: return DS.Typography.body()
        case .callout: return DS.Typography.callout()
        case .subheadline: return DS.Typography.subheadline()
        case .footnote: return DS.Typography.footnote()
        case .caption1: return DS.Typography.caption1()
        case .caption2: return DS.Typography.caption2()
        }
    }
}
