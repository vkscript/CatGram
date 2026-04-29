//
//  BDUISpacing.swift
//  CatGram
//

import UIKit

enum BDUISpacing: String, Codable {
    case xs, s, m, l, xl, xxl
    case zero
    
    var value: CGFloat {
        switch self {
        case .zero: return 0
        case .xs: return DS.Spacing.xs
        case .s: return DS.Spacing.s
        case .m: return DS.Spacing.m
        case .l: return DS.Spacing.l
        case .xl: return DS.Spacing.xl
        case .xxl: return DS.Spacing.xxl
        }
    }
}
