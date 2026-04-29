//
//  BDUIComponent.swift
//  CatGram
//

import Foundation

struct BDUIComponent: Codable {
    let type: BDUIComponentType
    let id: String?
    let content: BDUIContent
    let subviews: [BDUIComponent]?
    let constraints: BDUIConstraints?
    
    struct BDUIContent: Codable {
        // Common properties
        let backgroundColor: BDUIColor?
        let cornerRadius: BDUICornerRadius?
        let customCornerRadius: Double?
        let isHidden: Bool?
        let alpha: Double?
        
        // StackView properties
        let axis: BDUIAxis?
        let spacing: BDUISpacing?
        let alignment: BDUIAlignment?
        let distribution: BDUIDistribution?
        
        // Label properties
        let text: String?
        let font: BDUITypography?
        let textColor: BDUIColor?
        let textAlignment: BDUIAlignment?
        let numberOfLines: Int?
        
        // Button properties
        let title: String?
        let buttonStyle: BDUIButtonStyle?
        let action: BDUIAction?
        
        // TextField properties
        let placeholder: String?
        let fieldTitle: String?
        let isSecure: Bool?
        let keyboardType: String?
        
        // ImageView properties
        let imageUrl: String?
        let systemImage: String?
        let contentMode: BDUIContentMode?
        let tintColor: BDUIColor?
        
        // Spacer properties
        let spacerSize: BDUISpacing?
        
        // Card properties
        let hasShadow: Bool?
        
        // Error/Empty/Loading properties
        let message: String?
        let icon: String?
        let showRetryButton: Bool?
    }
    
    struct BDUIConstraints: Codable {
        let width: Double?
        let height: Double?
        let aspectRatio: Double?
    }
}
