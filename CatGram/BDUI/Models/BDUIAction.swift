//
//  BDUIAction.swift
//  CatGram
//

import Foundation

struct BDUIAction: Codable {
    let type: ActionType
    let payload: [String: String]?
    
    enum ActionType: String, Codable {
        case print
        case navigate
        case reload
        case dismiss
        case openUrl
        case custom
    }
}
