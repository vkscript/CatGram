//
//  BDUIActionHandler.swift
//  CatGram
//

import UIKit

protocol BDUIActionHandlerDelegate: AnyObject {
    func handleNavigation(to route: String, with params: [String: String]?)
    func handleReload()
    func handleDismiss()
}

final class BDUIActionHandler {
    
    weak var delegate: BDUIActionHandlerDelegate?
    
    func handle(_ action: BDUIAction) {
        switch action.type {
        case .print:
            handlePrint(action)
        case .navigate:
            handleNavigate(action)
        case .reload:
            handleReload(action)
        case .dismiss:
            handleDismiss(action)
        case .openUrl:
            handleOpenUrl(action)
        case .custom:
            handleCustom(action)
        }
    }
    
    private func handlePrint(_ action: BDUIAction) {
        if let message = action.payload?["message"] {
            print("📱 BDUI Action: \(message)")
        }
    }
    
    private func handleNavigate(_ action: BDUIAction) {
        guard let route = action.payload?["route"] else { return }
        delegate?.handleNavigation(to: route, with: action.payload)
    }
    
    private func handleReload(_ action: BDUIAction) {
        delegate?.handleReload()
    }
    
    private func handleDismiss(_ action: BDUIAction) {
        delegate?.handleDismiss()
    }
    
    private func handleOpenUrl(_ action: BDUIAction) {
        guard let urlString = action.payload?["url"],
              let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url)
    }
    
    private func handleCustom(_ action: BDUIAction) {
        print("📱 BDUI Custom Action: \(action.payload ?? [:])")
    }
}
